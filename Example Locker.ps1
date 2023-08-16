$InputText = Read-Host "Clave"

$Timestamp = [Math]::Floor(
  [datetimeoffset]::Now.ToUnixTimeMilliSeconds() / 1000 / 60
) + 2

for ($j = 0; $j -le 5; $j++) {
    $Timestamp -= 1

    # Crear un archivo temporal para contener el texto
    $TimestampText = "test" + $Timestamp
    $TimestampText | Set-Content -Path temp.txt

    # Utilizar PowerShell para calcular el hash MD5
    $md5_hash = (Get-FileHash -Path ".\temp.txt" -Algorithm MD5).Hash

    # Eliminar el archivo temporal
    Remove-Item temp.txt

    # Extraer los primeros 5 caracteres de la cadena
    $Clave = $md5_hash.Substring(0, 5)

    #Write-Host "******************************"
    #Write-Host "j: $j"
    #Write-Host "timestamp: $Timestamp"
    #Write-Host "MD5: $md5_hash"
    #Write-Host "Clave: $Clave"
    #Write-Host "input_text: $InputText"

    if ($Clave -eq $InputText) {
		Write-Host "Correcto!"
		pause
		exit
    }
}

Write-Host "Clave incorrecta!"
pause
exit 1
