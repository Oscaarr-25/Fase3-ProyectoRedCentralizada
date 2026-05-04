@echo off
:: Script de logon - Hospital General San GVA

:: Detectar grupo del usuario
net localgroup > nul 2>&1

:: Mapear unidades segun grupo
whoami /groups | findstr /i "GRP_Direccion" > nul
if %errorlevel%==0 (
    net use H: \\dc-hospitalgva\Direccion /persistent:no
    net use I: \\dc-hospitalgva\Administracion /persistent:no
    net use J: \\dc-hospitalgva\Medicos /persistent:no
    net use K: \\dc-hospitalgva\Enfermeria /persistent:no
    net use L: \\dc-hospitalgva\Sistemas /persistent:no
    msg * "Usuario %USERNAME%, la unidad H: es tu directorio en el servidor en modo lectura/escritura y las unidades I:, J:, K: y L: son de solo lectura."
    goto fin
)
whoami /groups | findstr /i "GRP_Administracion" > nul
if %errorlevel%==0 (
    net use H: \\dc-hospitalgva\Administracion /persistent:no
    net use I: \\dc-hospitalgva\Direccion /persistent:no
    net use J: \\dc-hospitalgva\Medicos /persistent:no
    net use K: \\dc-hospitalgva\Enfermeria /persistent:no
    net use L: \\dc-hospitalgva\Sistemas /persistent:no
    msg * "Usuario %USERNAME%, la unidad H: es tu directorio en el servidor en modo lectura/escritura y las unidades I:, J:, K: y L: son de solo lectura."
    goto fin
)
whoami /groups | findstr /i "GRP_Medicos" > nul
if %errorlevel%==0 (
    net use H: \\dc-hospitalgva\Medicos /persistent:no
    net use I: \\dc-hospitalgva\Direccion /persistent:no
    net use J: \\dc-hospitalgva\Administracion /persistent:no
    net use K: \\dc-hospitalgva\Enfermeria /persistent:no
    net use L: \\dc-hospitalgva\Sistemas /persistent:no
    msg * "Usuario %USERNAME%, la unidad H: es tu directorio en el servidor en modo lectura/escritura y las unidades I:, J:, K: y L: son de solo lectura."
    goto fin
)
whoami /groups | findstr /i "GRP_Enfermeria" > nul
if %errorlevel%==0 (
    net use H: \\dc-hospitalgva\Enfermeria /persistent:no
    net use I: \\dc-hospitalgva\Direccion /persistent:no
    net use J: \\dc-hospitalgva\Administracion /persistent:no
    net use K: \\dc-hospitalgva\Medicos /persistent:no
    net use L: \\dc-hospitalgva\Sistemas /persistent:no
    msg * "Usuario %USERNAME%, la unidad H: es tu directorio en el servidor en modo lectura/escritura y las unidades I:, J:, K: y L: son de solo lectura."
    goto fin
)
whoami /groups | findstr /i "GRP_Sistemas" > nul
if %errorlevel%==0 (
    net use H: \\dc-hospitalgva\Sistemas /persistent:no
    net use I: \\dc-hospitalgva\Direccion /persistent:no
    net use J: \\dc-hospitalgva\Administracion /persistent:no
    net use K: \\dc-hospitalgva\Medicos /persistent:no
    net use L: \\dc-hospitalgva\Enfermeria /persistent:no
    msg * "Usuario %USERNAME%, la unidad H: es tu directorio en el servidor en modo lectura/escritura y las unidades I:, J:, K: y L: son de solo lectura."
    goto fin
)
:fin
