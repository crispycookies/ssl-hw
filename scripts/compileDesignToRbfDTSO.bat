@ set _BAT_ROOT=%~dp0
@ set _BAT_ROOT=%_BAT_ROOT:\=/%
@ set CHERE_INVOKING=1
@ set HOME=.


@ set "QSYS_DESIGN=../HPSPlatform.qsys"
@ set "QUARTUS_DESIGN=../template.qpf"

call "./regenerateQsysDesign.bat"

:: call %EDS_SHELL% quartus_sh --flow compile %QUARTUS_DESIGN%

call %EDS_SHELL% quartus_map --read_settings_files=on --write_settings_files=off %QUARTUS_DESIGN% -c template
call %EDS_SHELL% quartus_cdb --merge --read_settings_files=off --write_settings_files=off %QUARTUS_DESIGN% -c template
call %EDS_SHELL% quartus_fit --read_settings_files=off --write_settings_files=off %QUARTUS_DESIGN% -c template
call %EDS_SHELL% quartus_asm --read_settings_files=off --write_settings_files=off %QUARTUS_DESIGN% -c template

call "./generateDTSandOverlay.bat"
call "./generateRbfFromSof.bat"
