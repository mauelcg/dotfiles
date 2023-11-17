@echo off

@REM Default macros to run when running 'setup <macro>'
set "run=python main.py"

@REM Python version
set "version=3.6.8"

@REM Directory where Python will be installed.
@REM NOTE: This will be used to run environment configuration without refreshing %PATH% environment variables.
set "targetdir=%LocalAppData%\Programs\Python\Python%version:.=%"

set "rems=__pycache__"
set "rems=%rems%;pyvenv.cfg"
set "rems=%rems%;dist"
set "rems=%rems%;build"

set "envs=python-%version%-amd64.exe"
set "envs=%envs%;Scripts"
set "envs=%envs%;Lib"
set "envs=%envs%;Include"
set "envs=%envs%;dist"
set "envs=%envs%;build"

:main
    if "%1"=="clean" (
        call :clean
        goto :eof
    ) else if [%1]==[] (
        @REM If no existing environment exists, we create one
        echo Running `setup build` instead
        call :check-python
        if errorlevel 1 (
            echo [exiting]
            exit /b 1
        )
        call :configure-environment
    ) else if "%1"=="build" (
        if "%2"=="--python" (
            if [%3]==[] (
                echo Invalid Python executable location
            ) else (
                set "python=%3"
                echo Using %3
                call :configure-environment
            )
            goto :eof
        ) else if "%2"=="-p" (
            if [%3]==[] (
                echo Invalid Python executable location
            ) else (
                set "python=%3"
                echo Using %3
                call :configure-environment
            )
            goto :eof
        )
        call :check-python
        if errorlevel 1 (
            echo [exiting]
            exit /b 1
        )
        call :configure-environment
    ) else if "%1"=="run" (
        @REM Use existing Python environment
        if exist "%~dp0Scripts" (
            echo Activating Environment
            call "%~dp0Scripts\activate.bat"
            %run%
            goto :eof
        ) else if "%2"=="--python" (
            if [%3]==[] (
                echo Invalid Python executable location
            ) else (
                set "python=%3"
                echo Using %3
                call :configure-environment
                %run%
            )
            goto :eof
        ) else if "%2"=="-p" (
            if [%3]==[] (
                echo Invalid Python executable location
            ) else (
                set "python=%3"
                echo Using %3
                call :configure-environment
                %run%
            )
            goto :eof
        )
        call :check-python
        if errorlevel 1 (
            echo [exiting]
            exit /b 1
        )
        call :configure-environment
        %run%
    ) else (
        echo "Unknown argument(s). Running `setup build` instead"
        call :check-python
        if errorlevel 1 (
            echo [exiting]
            exit /b 1
        )
        call :configure-environment
    )

    goto :eof

:configure-environment
    @REM Delete existing virtual environment related directories
    call :clean
    call :add-local

    @REM Create virtual environment from the project's root directory (i.e. directory of the calling script)
    @REM NOTE: Here we don't install 'virtualenv' as later versions of Python have 'venv' package installed.
    echo Creating Python environment
    %python% -m venv "%cd%"
    echo.

    if errorlevel 1 (
        echo Environment configuration failed.
        call :clean
        exit /b 1
    )

    if "%useconda%"=="1" (
        echo Deactivating 'conda' environment "%condaenv%"
        call conda deactivate
        echo.
    )

    @REM Activate Environment
    echo Activating 'project' environment
    call "%~dp0Scripts\activate.bat"

    @REM In case the project requires, we need to install local packages, although not every project mandates the following to be installed.
    @REM if "%version%"=="3.6.8" (
    @REM     pip install "DVDSpecReader"
    @REM     pip install "p4wrapper"
    @REM )

    @REM Install Packages from 'requirements.txt' | 'setup.py'
    @REM NOTE: At this point, we use project-specific Python.
    @REM Try upgrading pip and setuptools
    "%~dp0Scripts\python.exe" -m pip install --upgrade pip
    "%~dp0Scripts\python.exe" -m pip install --upgrade setuptools

    if errorlevel 1 (
        echo Environment configuration failed.
        call :clean
        exit /b 1
    )

    echo Installing packages
    if exist "%~dp0requirements.txt" (
        pip install -r "%~dp0requirements.txt"
    )
    if exist "%~dp0setup.py" (
        @REM Using setup.py requires 'setuptools'
        python "%~dp0setup.py" install
    )

    echo.

    if errorlevel 1 (
        echo Environment configuration failed.
        call :clean
        exit /b 1
    )

    goto :eof

:configure-python
    echo Executing "conda --version"
    call conda --version
    echo.

    if errorlevel 1 (
        echo Run this script using 'anaconda' or 'conda' prompt.
        exit /b 1
    )

    @REM Assuming `conda` is installed
    set "condaenv=sd33_automation_py%version:.=%"
    set "useconda=1"

    @REM Use
    echo Checking existing environment "%condaenv%"
    call conda activate %condaenv% 2>nul
    echo.

    if errorlevel 1 (
        echo Creating 'conda' environment "%condaenv%"
        call conda create -n %condaenv% -y python=%version%
        echo.

        echo Activating 'conda' environment "%condaenv%"
        call conda activate %condaenv%
        echo.
    )

    set "python=python"

    goto :eof

:clean
    for %%a in (%envs%) do (
        if exist %%a (
            if "%%a"=="Scripts" (
                echo Deactivating environment
                call "%~dp0Scripts\deactivate.bat"
                echo Deleting "%~dp0Scripts"
                powershell -Command "Remove-Item -Path '%~dp0Scripts' -Recurse -Force"
            ) else (
                echo Deleting "%~dp0%%a"
                @REM Enclose in quotation marks ("") to allow for paths with whitespace
                powershell -Command "Remove-Item -Path '%~dp0%%a' -Recurse -Force"
            )

            echo.
        )
    )

    powershell -Command "Get-ChildItem *.egg-info | foreach { Remove-Item -Path $_.FullName -Recurse -Force }"

    for %%a in (%rems%) do (
        if exist %%a (
            echo Deleting "%~dp0%%a"
            @REM Enclose in quotation marks ("") to allow for paths with whitespace
            powershell -Command "Remove-Item -Path '%~dp0%%a' -Recurse -Force"

            echo.
        )
    )

    goto :eof

:check-python
    set "command=where python"

    @REM Get the output of command %command%
    for /f "usebackq eol=; tokens=*" %%a in (`%command%`) do (
        @REM Look for Python with appropriate version
        echo Executing "%%a --version"
        for /f "usebackq eol=; tokens=*" %%b in (`%%a --version`) do (
            echo %%b | findstr /C:"%version%" 1>nul
            if not errorlevel 1 (
                echo Python %version% found: %%a
                set "python=%%a"
                goto :eof
            )
        )
        %%a --version
        echo.
    )

    echo No local Python with version %version% found.
    echo.

    call :configure-python

:add-local
    @REM To access local PIP server, we need to write to %AppData%/pip a configuration file named 'pip.ini'
    if not exist "%AppData%\pip" (
        powershell -Command "New-Item -ItemType Directory -Path '%AppData%\pip'"
    )
    if not exist "%AppData%\pip\pip.ini" (
        powershell -Command "New-Item -ItemType File -Path '%AppData%\pip\pip.ini'"
        powershell -Command "Add-Content -Path '%AppData%\pip\pip.ini' -Value '[global]'"
        powershell -Command "Add-Content -Path '%AppData%\pip\pip.ini' -Value 'extra-index-url=http://10.191.23.81:8080'"
        powershell -Command "Add-Content -Path '%AppData%\pip\pip.ini' -Value 'trusted-host=10.191.23.81'"
    )

    goto :eof
