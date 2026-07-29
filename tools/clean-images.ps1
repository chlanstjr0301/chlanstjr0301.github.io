# 글에서 지운(참조 안 하는) 고아 이미지를 _to_delete\orphan-images 로 이동
# 사용: 루트의 clean-images.bat 더블클릭
$root  = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$trash = Join-Path $root "_to_delete\orphan-images"
$exts  = ".png", ".jpg", ".jpeg", ".gif", ".svg", ".webp"
$moved = 0

Get-ChildItem (Join-Path $root "content") -Recurse -Filter "index.md" | ForEach-Object {
  $dir = $_.Directory
  $md  = Get-Content $_.FullName -Raw
  Get-ChildItem $dir -File | Where-Object { $exts -contains $_.Extension.ToLower() } | ForEach-Object {
    if ($md -notmatch [regex]::Escape($_.Name)) {
      New-Item -ItemType Directory -Force -Path $trash | Out-Null
      Move-Item $_.FullName (Join-Path $trash ($dir.Name + "--" + $_.Name)) -Force
      Write-Host ("  orphan → " + $dir.Name + "\" + $_.Name)
      $script:moved++
    }
  }
}
if ($moved -eq 0) { Write-Host "  고아 이미지 없음 - 깨끗함" }
else { Write-Host ("  " + $moved + "개를 _to_delete\orphan-images 로 옮김 (확인 후 폴더째 삭제)") }
