# Backup From a Manifest
<#
Drives off a Manifest File...  Manifest File Name and path can be submitted by ARGS[0]
Options for backup form is ZIP , L1ZIP or PLAIN
	All presume recursive file collection from the node point provided
#>
if ($args[0].length -eq 0) {
    $Spath = "$PSScriptRoot\Manifest.txt"
    }
else {
    $Spath = $args[0]
    }
$pieces = get-content -Path $Spath

$tdy = get-date -Format "yyyyMMddHHmm"
$Tpath = "E:\Bkup$tdy"

if (test-path -Path $Tpath) {} 
else { new-item -Path $Tpath -ItemType directory -Force }

Foreach ($piece in $pieces) {
   $APiece = $piece -split ";"
    if ($APiece[1] -eq "PLAIN") {
       $lastslash = $Apiece[0].tostring().lastindexof("\")
       $zname = $Apiece[0].substring($lastslash+1)
       "$Tpath\$zname"
       if (test-path -Path "$Tpath\$zname") {} 
       else { new-item -Path "$Tpath\$zName" -ItemType directory -Force }

       $GCI = Get-ChildItem -Path $($Apiece[0])
       $GCI | Copy-Item  -Destination "$Tpath\$zname" -Recurse
    }
    elseif ($APiece[1] -eq "L1ZIP") {
       $lastslash = $Apiece[0].tostring().lastindexof("\")
       $zname = $Apiece[0].substring($lastslash+1)
       "$Tpath\$zname"
       if (test-path -Path "$Tpath\$zname") {} 
       else { new-item -Path "$Tpath\$zName" -ItemType directory -Force }

       $GCI = Get-ChildItem -Path $($Apiece[0])
       Foreach ($Child in $GCI) {
          $lastslash = $Child.Fullname.tostring().lastindexof("\")
          $cname = $Child.Fullname.substring($lastslash+1)
          $lastperiod = $Child.Fullname.tostring().lastindexof(".")
          if ($lastperiod -gt $lastslash) {
             $cname += ".zip"
           } # hack to get.ca and .com to .zip
             # generate a Zip file for the $Apiece
           "$Tpath\$zname\$cname"
          Compress-Archive -Path $Child.FullName -DestinationPath "$Tpath\$zname\$cname" -CompressionLevel Optimal 
       }
    }
    else {
       # get the name of the $piece
       $lastslash = $Apiece[0].tostring().lastindexof("\")
       $zname = $Apiece[0].substring($lastslash+1)
       $lastperiod = $Apiece[0].tostring().lastindexof(".")
       if ($lastperiod -gt $lastslash) {
         $zname += ".zip"
       } #hack to get.ca and .com to .zip
       # generate a Zip file for the $Apiece
       "$Tpath\$zname"
       if (test-path -Path "$Tpath\$zname") {
          #"Update"
       Compress-Archive -path $Apiece[0] -destinationpath "$Tpath\$zname" -compressionlevel optimal -update
       } #Update ZIP
       else {
          #"Create"
        Compress-Archive -path $Apiece[0] -destinationpath "$Tpath\$zname" -compressionlevel optimal
        } # New ZIP
    } # Backup type is ZIP
   } #Foreach Piece