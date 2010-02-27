To use this program you must have 
		TotalMedia Theater or another bluray 
		playing software installed and SlySoft's 
		Virtual CloneDrive installed.
	
	 You must also supply the following 
		arguments without the commas, 
		The iso's location with double quotes 
		surrounding it, 
		VirtualClone VCDmount.exe location 
		with double quotes surrounding it, 
		the drive number of one of the 
	   Virtual CloneDrive's that you setup 
		in the setup menu (staring with drive 0),
	 	and the bluray players location 
		with double quotes surrounding it.
	 
	 An example of this for the external 
		player commands with XBMC would be: 
		mount "{1}" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\vcdmount.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe"
	
	 Another normal example of this: 
		mount "C:\Batman Begins.iso" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\vcdmount.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe"
	 
	 If along with mounting the iso and 
	 	playing it you would like to change 
	 	the resolution and refresh rate 
	 	you will have to download and 
		install 12noon display changer 
		which is free @ 
		http://www.12noon.com, 
	 	an example with xbmc would be:
	 	mount "{1}" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\vcdmount.exe" 0 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe" "F:\Program Files\Program Files (x86)\12noon Display Changer\dc64cmd.exe" 1866 1056 32 24
	 	where "F:\Program Files\Program Files (x86)\12noon Display Changer\dc64cmd.exe" is the location of the exe for display changer,
		where 1866 1056 32 24 is the width, height, depth, and refresh rate respectively.
		
To be able to automatically launch the tmt or another bluray player when the iso is selected in XBMC, 
	you must edit the playercorefactory.xml in the XBMC/system folder where xbmc is installed.
	An example of mine is as follows:
	
	<player name="TMTPlayer Mount ISO" type="ExternalPlayer" audio="false" video="true">
		<filename>C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\ISO Mount.exe</filename>
		<args>"{1}" "C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\vcdmount.exe" 1 "F:\Program Files\Program Files (x86)\ArcSoft\TotalMedia Theatre 3\uDigital Theatre.exe" "F:\Program Files\Program Files (x86)\12noon Display Changer\dc64cmd.exe" 1866 1056 32 24</args>
		<forceontop>false</forceontop>
		<hidexbmc>false</hidexbmc>
		<hidecursor>false</hidecursor>
	</player>
	
	to have them automatically launched in tmt
    <rules action="prepend">
		<rule filetypes="iso" filename="*.bluray.iso" player="TMTPlayer Mount ISO"/>
    </rules>