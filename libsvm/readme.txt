https://www.mathworks.com/matlabcentral/answers/313298-i-already-have-mingw-on-my-computer-how-do-i-configure-it-to-work-with-matlab



MATLAB detects the MinGW compiler by reading the environment variable MW_MINGW64_LOC. When you install MinGW from the MATLAB Add-Ons menu, MATLAB sets this variable. The following instructions can be used to set this environment variable manually.
For MATLAB R2017b and later:
Verify you have installed MinGW-w64 version 5.3 before following these steps.
1) Download the attached MATLAB function 'configuremingw'.
2) Identify the full path to the MinGW installation directory containing the MinGW compiler binaries. This is identified as MINGWROOT.
3) In the MATLAB Command Window run:

>> configuremingw(MINGWROOT)
Alternatively, run:

>> configuremingw
Then navigate to MINGWROOT.
For MATLAB R2015b through R2017a:
Verify you have installed MinGW-w64 version 4.9.2 before following these steps.
The MW_MINGW64_LOC environment variable can be (A) set for the entire system level or (B) set temporarily every time you open MATLAB. Administrative privileges are required to set MW_MINGW64_LOC as a system environment variable. No special privileges are required to set the environment variable temporarily.
(A) To set MW_MINGW64 as a system environment variable on Windows 7/8/10:
Make sure you have administrative privileges.
Select Computer from the Start menu.
Choose System properties from the context menu.
Click Advanced system settings > Advanced tab.
Click Environment Variables.
Under System variables, select New.
In the New System Variable dialog box, type MW_MINGW64_LOC in the Variable name field.
In the Variable value field, type the location of the MinGW-w64 compiler installation, for example, 'C:\TDM-GCC-64'.
Click "OK" to close the dialog boxes, then close the Control Panel dialog box.
(B) To set MW_MINGW64 as a temporary environment variable using MATLAB:
Run the following in the MATLAB Command Window:

>> setenv('MW_MINGW64_LOC',folder)
where 'folder' is the installation directory of MinGW. For example, 'C:\TDM-GCC-64'. This command will need to be run every time you start MATLAB for MATLAB to correctly use MinGW. You can consider adding the above command to your 'startup.m' file. This will execute the command every time MATLAB starts up.
To Verify:
After performing the above steps, you can verify if the compiler was recognized by MATLAB by running the following command:

>> mex -setup