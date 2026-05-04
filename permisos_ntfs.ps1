# Script de creación de estructura y permisos NTFS - Hospital General San GVA

# Crear directorios
$departamentos = @("Direccion","Administracion","Medicos","Enfermeria","Sistemas")

foreach ($dep in $departamentos) {
    New-Item -ItemType Directory -Path "E:\$dep" -Force
}

# Desactivar herencia y asignar permisos
$carpetas = @("Direccion","Administracion","Medicos","Enfermeria","Sistemas")
$grupos = @("GRP_Direccion","GRP_Administracion","GRP_Medicos","GRP_Enfermeria","GRP_Sistemas")

foreach ($carpeta in $carpetas) {
    $ruta = "E:\$carpeta"
    $acl = Get-Acl $ruta
    $acl.SetAccessRuleProtection($true, $false)

    # Dar control total al grupo propietario
    $grupoPropietario = "SAN-GVA\GRP_$carpeta"
    $regla = New-Object System.Security.AccessControl.FileSystemAccessRule($grupoPropietario,"FullControl","ContainerInherit,ObjectInherit","None","Allow")
    $acl.AddAccessRule($regla)

    # Dar solo lectura al resto de grupos
    foreach ($grupo in $grupos) {
        if ($grupo -ne "GRP_$carpeta") {
            $regla = New-Object System.Security.AccessControl.FileSystemAccessRule("SAN-GVA\$grupo","ReadAndExecute","ContainerInherit,ObjectInherit","None","Allow")
            $acl.AddAccessRule($regla)
        }
    }

    # Dar control total a Administradores
    $regla = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administradores","FullControl","ContainerInherit,ObjectInherit","None","Allow")
    $acl.AddAccessRule($regla)

    Set-Acl $ruta $acl
}

Write-Host "Permisos aplicados correctamente." -ForegroundColor Green

# Compartir carpetas
foreach ($carpeta in $carpetas) {
    New-SmbShare -Name $carpeta -Path "E:\$carpeta" -FullAccess "Todos"
}

Write-Host "Carpetas compartidas correctamente." -ForegroundColor Green
