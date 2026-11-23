/* Munseok's Log — 사이트 공통 스크립트
   1. 라이트/다크 전환     2. 목차 강조       3. 코드 복사
   4. 팝오버(각주·수식·인용 미리보기)        5. 수식 번호 참조 링크
   6. 검색(Pagefind)       7. 조회수(GoatCounter, 설정 시)              */
(function () {
  'use strict';
  var root = document.documentElement;

  /* ---------- 1. 테마 ---------- */
  var btn = document.getElementById('theme-toggle');
  if (btn) {
    btn.setAttribute('aria-pressed', root.dataset.theme === 'dark');
    btn.addEventListener('click', function () {
      var next = root.dataset.theme === 'dark' ? 'light' : 'dark';
      root.dataset.theme = next;
      btn.setAttribute('aria-pressed', next === 'dark');
      try { localStorage.setItem('theme', next); } catch (e) {}
      var frame = document.querySelector('iframe.giscus-frame');
      if (frame) frame.contentWindow.postMessage(
        { giscus: { setConfig: { theme: next === 'dark' ? 'transparent_dark' : 'light' } } },
        'https://giscus.app');
    });
  }

  /* ---------- 2. 목차: 지금 읽는 제목 강조 ---------- */
  (function () {
    var toc = document.getElementById('toc-sidebar');
    if (!toc) return;
    var map = {};
    toc.querySelectorAll('a[href^="#"]').forEach(function (a) {
      map[decodeURIComponent(a.getAttribute('href').slice(1))] = a;
    });
    var heads = Array.prototype.filter.call(
      document.querySelectorAll('.post-content h2[id],.post-content h3[id],.post-content h4[id]'),
      function (h) { return map[h.id]; });
    if (!heads.length) return;
    var active = null;
    function onScroll() {
      var cur = heads[0].id;
      for (var i = 0; i < heads.length; i++) {
        if (heads[i].getBoundingClientRect().top <= 100) cur = heads[i].id; else break;
      }
      if (active) active.classList.remove('active');
      active = map[cur];
      active.classList.add('active');
    }
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  })();

  /* ---------- 3. 코드 복사 ---------- */
  document.querySelectorAll('.code-copy').forEach(function (b) {
    b.addEventListener('click', function () {
      var box = b.closest('.codeblock');
      var code = box.querySelector('.lntd:last-child code') || box.querySelector('pre code') || box.querySelector('pre');
      var text = code ? code.innerText.replace(/\n$/, '') : '';
      var done = function () {
        b.textContent = '복사됨';
        b.classList.add('done');
        setTimeout(function () { b.textContent = '복사'; b.classList.remove('done'); }, 1500);
      };
      if (navigator.clipboard) navigator.clipboard.writeText(text).then(done, function () {});
      else {
        var ta = document.createElement('textarea'); ta.value = text; document.body.appendChild(ta);
        ta.select(); try { document.execCommand('copy'); done(); } catch (e) {} ta.remove();
      }
    });
  });

  /* ---------- 4. 팝오버 ---------- */
  var canHover = window.matchMedia && matchMedia('(hover: hover) and (pointer: fine)').matches;
  var pop = null, hideTimer = null;
  function getPop() {
    if (pop) return pop;
    pop = document.createElement('div');
    pop.className = 'popover';
    pop.setAttribute('role', 'tooltip');
    pop.addEventListener('mouseenter', function () { clearTimeout(hideTimer); });
    pop.addEventListener('mouseleave', hidePop);
    document.body.appendChild(pop);
    return pop;
  }
  function showPop(anchor, node, wide) {
    clearTimeout(hideTimer);
    var p = getPop();
    p.innerHTML = '';
    p.appendChild(node);
    p.classList.toggle('wide', !!wide);
    p.style.display = 'block';
    var r = anchor.getBoundingClientRect();
    var w = p.offsetWidth, vw = document.documentElement.clientWidth;
    var left = Math.min(Math.max(12, r.left + window.scrollX - 24), window.scrollX + vw - w - 12);
    var top = r.bottom + window.scrollY + 8;
    // 화면 아래로 넘치면 위로 띄운다
    if (r.bottom + p.offsetHeight + 16 > window.innerHeight && r.top > p.offsetHeight + 16) {
      top = r.top + window.scrollY - p.offsetHeight - 8;
    }
    p.style.left = left + 'px';
    p.style.top = top + 'px';
  }
  function hidePop() {
    clearTimeout(hideTimer);
    hideTimer = setTimeout(function () { if (pop) pop.style.display = 'none'; }, 120);
  }
  function bindPop(a, build, wide) {
    if (!canHover) return;
    var open = function () { var n = build(); if (n) showPop(a, n, wide); };
    a.addEventListener('mouseenter', open);
    a.addEventListener('focus', open);
    a.addEventListener('mouseleave', hidePop);
    a.addEventListener('blur', hidePop);
  }

  // 각주: 번호에 올리면 내용 미리보기 (터치 기기는 기존처럼 글 끝으로 이동)
  function bindFootnotes() {
    document.querySelectorAll('.post-content a.footnote-ref').forEach(function (a) {
      bindPop(a, function () {
        var li = document.getElementById(decodeURIComponent(a.getAttribute('href').slice(1)));
        if (!li) return null;
        var c = li.cloneNode(true);
        c.removeAttribute('id');
        c.querySelectorAll('.footnote-backref').forEach(function (x) { x.remove(); });
        var d = document.createElement('div');
        d.className = 'pop-note';
        d.innerHTML = c.innerHTML;
        return d;
      });
    });
  }

  // 인용 [n]: 참고문헌 항목 미리보기
  function bindCites() {
    document.querySelectorAll('.post-content a.cite-ref').forEach(function (a) {
      bindPop(a, function () {
        var li = document.getElementById(decodeURIComponent(a.getAttribute('href').slice(1)));
        if (!li) return null;
        var d = document.createElement('div');
        d.className = 'pop-note';
        d.innerHTML = li.innerHTML;
        return d;
      });
    });
  }

  /* ---------- 5. 수식 번호 참조 ----------
     \tag{8}을 단 수식에 id="eq-8"을 붙이고, 본문의 "식 (8)", "식 (8), (9)", "Eq. (8)"을 링크로 바꾼다. */
  function bindEquations() {
    var content = document.querySelector('.post-content');
    if (!content) return;
    var eqs = {};
    content.querySelectorAll('.katex-display').forEach(function (k) {
      var tag = k.querySelector('.tag');
      if (!tag) return;
      var n = tag.textContent.replace(/[()\s]/g, '');
      if (!n || eqs[n]) return;
      var box = k.closest('.math-display') || k;
      box.id = 'eq-' + n;
      eqs[n] = box;
    });
    if (!Object.keys(eqs).length) return;

    var walker = document.createTreeWalker(content, NodeFilter.SHOW_TEXT, {
      acceptNode: function (t) {
        if (!/(식|Eq\.?|eq\.)\s*\(/.test(t.nodeValue)) return NodeFilter.FILTER_REJECT;
        if (t.parentElement.closest('.katex, pre, code, a, .footnotes')) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    var re = /((?:식|Eq\.?|eq\.)\s*)(\(\d+(?:\.\d+)?[a-z]?\)(?:\s*(?:,|와|과|~|–|-)\s*\(\d+(?:\.\d+)?[a-z]?\))*)/g;
    nodes.forEach(function (t) {
      var s = t.nodeValue, out = document.createDocumentFragment(), last = 0, m, hit = false;
      re.lastIndex = 0;
      while ((m = re.exec(s))) {
        out.appendChild(document.createTextNode(s.slice(last, m.index) + m[1]));
        m[2].split(/(\(\d+(?:\.\d+)?[a-z]?\))/).forEach(function (part) {
          var mm = /^\((\d+(?:\.\d+)?[a-z]?)\)$/.exec(part);
          if (mm && eqs[mm[1]]) {
            var a = document.createElement('a');
            a.href = '#eq-' + mm[1];
            a.className = 'eq-ref';
            a.textContent = part;
            out.appendChild(a);
            hit = true;
          } else if (part) out.appendChild(document.createTextNode(part));
        });
        last = re.lastIndex;
      }
      if (!hit) return;
      out.appendChild(document.createTextNode(s.slice(last)));
      t.parentNode.replaceChild(out, t);
    });
    content.querySelectorAll('a.eq-ref').forEach(function (a) {
      bindPop(a, function () {
        var box = eqs[a.getAttribute('href').slice(4)];
        if (!box) return null;
        var c = box.cloneNode(true);
        c.removeAttribute('id');
        return c;
      }, true);
    });
  }

  // KaTeX가 있는 글은 수식 렌더 뒤에(scripts.html의 onload), 없는 글은 바로 실행
  window.siteAfterMath = function () { bindEquations(); };
  bindFootnotes();
  bindCites();

  /* ---------- 6. 검색 (Pagefind) ---------- */
  (function () {
    var dlg = document.getElementById('search-dialog');
    var open = document.getElementById('search-open');
    if (!dlg || !open) return;
    var loaded = false;
    function load() {
      if (loaded) return;
      loaded = true;
      var css = document.createElement('link');
      css.rel = 'stylesheet'; css.href = '/pagefind/pagefind-ui.css';
      document.head.appendChild(css);
      var s = document.createElement('script');
      s.src = '/pagefind/pagefind-ui.js';
      s.onload = function () {
        /* global PagefindUI */
        new PagefindUI({
          element: '#search-ui', showSubResults: true, showImages: false, resetStyles: false,
          translations: { placeholder: '글 제목·본문 검색', zero_results: '"[SEARCH_TERM]"에 대한 결과가 없습니다' }
        });
        var input = dlg.querySelector('input');
        if (input) input.focus();
      };
      s.onerror = function () {
        document.getElementById('search-ui').innerHTML =
          '<p class="search-note">검색 색인이 없습니다. 배포된 사이트에서만 동작합니다 (로컬에서는 <code>npx pagefind --site public</code> 후 확인).</p>';
      };
      document.head.appendChild(s);
    }
    function show() {
      load();
      if (dlg.showModal) dlg.showModal(); else dlg.setAttribute('open', '');
      var input = dlg.querySelector('input');
      if (input) setTimeout(function () { input.focus(); }, 30);
    }
    open.addEventListener('click', show);
    dlg.addEventListener('click', function (e) { if (e.target === dlg) dlg.close(); });
    document.addEventListener('keydown', function (e) {
      if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') { e.preventDefault(); show(); }
      else if (e.key === '/' && !/input|textarea/i.test(document.activeElement.tagName) && !dlg.open) { e.preventDefault(); show(); }
    });
  })();

  /* ---------- 7. 조회수 (GoatCounter) ----------
     hugo.toml params.goatcounter 를 채웠을 때만 동작한다. [data-views] 요소에 숫자를 넣는다 (기록 없으면 0). */
  (function () {
    var code = root.dataset.goatcounter;
    if (!code) return;
    var base = 'https://' + code + '.goatcounter.com/counter/';
    document.querySelectorAll('[data-views]').forEach(function (el) {
      var path = el.getAttribute('data-views');
      fetch(base + encodeURIComponent(path === 'TOTAL' ? 'TOTAL' : path) + '.json')
        // 기록이 아직 없는 글은 404와 함께 {"count":"0"}이 온다 → 0으로 표시
        .then(function (r) { return r.json().catch(function () { return { count: '0' }; }); })
        .then(function (j) {
          el.querySelector('.views-n').textContent = (j && j.count) || '0';
          el.hidden = false;
        }).catch(function () {});   // 광고 차단 등으로 요청이 막히면 숨긴 채로 둔다
    });
  })();
})();
