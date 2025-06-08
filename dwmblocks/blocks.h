//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/   /*Command*/                             /*Update Interval*/   /*Update Signal*/
	//{"", "/home/nico/repo/scrips/colorTest.sh",        0,                   69},
	{"", "/home/nico/repo/scrips/name.sh",             0,                   1},
	{"", "/home/nico/repo/scrips/ip.sh",               300,                 2},
	{"", "/home/nico/repo/scrips/display.sh",          120,                 3},
	{"", "/home/nico/repo/scrips/mic.sh",              300,                 4},
	{"", "/home/nico/repo/scrips/volume.sh",           300,                 5},
	{"", "/home/nico/repo/scrips/battery.sh",          60,                  6},
	{"", "/home/nico/repo/scrips/dateTime.sh",         60,                  7},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = "|";
static unsigned int delimLen = 5;
