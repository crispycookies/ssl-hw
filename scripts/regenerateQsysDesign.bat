@ set _BAT_ROOT=%~dp0
@ set _BAT_ROOT=%_BAT_ROOT:\=/%
@ set CHERE_INVOKING=1
@ set HOME=.


@ set "QSYS_DESIGN=../HPSPlatform.qsys"
@ set "QUARTUS_DESIGN=../template.qpf"

%EDS_SHELL% qsys-generate --synthesis=VERILOG %QSYS_DESIGN%