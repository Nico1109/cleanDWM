/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const unsigned int gappih    = 6;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 6;       /* vert inner gap between windows */
static const unsigned int gappoh    = 8;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 8;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int statusbar_offset   = 0;        /* manual statusbar horizontal offset adjustment */
static const char *fonts[]          = { "monospace:size=14", "3270 Nerd Font:size=14" };
static const char dmenufont[]       = "monospace:size=14";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#267365";
static const char col_yellow[]      = "#fce630";
static const char col_black[]       = "#000000";
static const char col_gray[]        = "#222222";
static const char col_white[]       = "#ffffff";
static const char col_dark_yellow[] = "#F2CB05";
static const char col_orange[]      = "#F47531";
static const char col_red[]         = "#F23030";
static const char col_violet[]      = "#D8215E";
static const char col_green[]       = "#4CAF50";  /* Medium green */
static const char col_dark_green[]  = "#2E7D32";  /* Dark green */
static const char col_light_green[] = "#8BC34A";  /* Light green */
static const char col_bright_red[]  = "#FF5252";  /* Bright red for alerts */
static const char col_dark_red[]    = "#C62828";  /* Dark red for critical */
static const char col_amber[]       = "#FFC107";  /* Amber for warnings */
static const char col_deep_orange[] = "#FF5722";  /* Deep orange */
static const char col_blue[]        = "#2196F3";  /* Blue for info */
static const char col_light_blue[]  = "#03A9F4";  /* Light blue */
static const char col_indigo[]      = "#3F51B5";  /* Indigo for low states */
static const char col_purple[]      = "#9C27B0";  /* Purple accent */
static const char col_teal[]        = "#009688";  /* Teal for network */
static const char col_bright_green[] = "#66BB6A";  /* Bright green for high/good states */
static const char col_forest_green[] = "#388E3C";  /* Forest green for battery full */
static const char col_lime_green[]   = "#9CCC65";  /* Lime green for medium-high states */
static const char col_yellow_green[] = "#CDDC39";  /* Yellow-green transition */
static const char col_light_orange[] = "#FFB74D";  /* Light orange for medium states */
static const char col_coral[]        = "#FF7043";  /* Coral for medium-high alerts */
static const char col_crimson[]      = "#DC143C";  /* Crimson for high alerts */
static const char col_navy_blue[]    = "#1565C0";  /* Navy blue for low brightness */
static const char col_sky_blue[]     = "#42A5F5";  /* Sky blue for medium brightness */
static const char col_powder_blue[]  = "#81D4FA";  /* Powder blue for high brightness */

static const char *colors[][3]      = {
	/*               fg                   bg                border   */
	[SchemeNorm]  = { col_bright_red,     col_gray,         col_navy_blue },	/*01*/
	[SchemeSel]   = { col_white,       	  col_navy_blue,    col_white },	    /*02*/
	[SchemeWarn]  = { col_black,       	  col_yellow,       col_red },		    /*03*/
	[SchemeUrgent]= { col_white,       	  col_violet,       col_red },		    /*04*/
	[Icon1]       = { col_yellow,      	  col_gray,         col_white },  	    /*05*/
	[Icon2]       = { col_white,       	  col_gray, 	    col_white },  	    /*06*/
	[Icon3]       = { col_bright_green,   col_gray,  	    col_white },  	    /*07*/
	[Icon4]       = { col_green,          col_gray,  	    col_white },  	    /*08*/
	[Icon5]       = { col_lime_green,     col_gray,  	    col_white },  	    /*09*/
	[NOTWORKING]  = { col_black,      	  col_white,        col_white },  	    /*0A NOT WORKING*/
	[Icon6]       = { col_yellow_green,   col_gray,  	    col_white },  	    /*0B*/
	[Icon7]       = { col_amber,          col_gray,  	    col_white },  	    /*0C*/
	[Icon8]       = { col_light_orange,   col_gray,  	    col_white },  	    /*0D*/
	[Icon9]       = { col_coral,          col_gray,  	    col_white },  	    /*0E*/
	[Icon10]      = { col_crimson,        col_gray,  	    col_white },  	    /*0F*/
	[Icon11]      = { col_navy_blue,      col_gray,  	    col_white },  	    /*10*/
	[Icon12]      = { col_sky_blue,       col_gray,  	    col_white },  	    /*11*/
	[Icon13]      = { col_powder_blue,    col_gray,  	    col_white },  	    /*12*/
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static int attachbelow = 1;    /* 1 means attach after the currently active window */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

#include "movestack.c"
/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray, "-nf", col_bright_red, "-sb", col_white, "-sf", col_navy_blue, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.03} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.03} },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_period, toggleAttachBelow, 				{0} },
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY,                       XK_space,  zoom,           {0} },
	{ MODKEY|Mod4Mask,              XK_u,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_i,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_o,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_6,      incrihgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,      incrihgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_7,      incrivgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,      incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_8,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,      incrohgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_9,      incrovgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,      incrovgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_F1,     setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_F2,     setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_F3,     setlayout,      {.v = &layouts[5]} },
	{ MODKEY,                       XK_F4,     setlayout,      {.v = &layouts[6]} },
	{ MODKEY,                       XK_F5,     setlayout,      {.v = &layouts[7]} },
	{ MODKEY,                       XK_F6,     setlayout,      {.v = &layouts[8]} },
	{ MODKEY,                       XK_F7,     setlayout,      {.v = &layouts[9]} },
	{ MODKEY,                       XK_F8,     setlayout,      {.v = &layouts[10]} },
	{ MODKEY,                       XK_F9,     setlayout,      {.v = &layouts[11]} },
	{ MODKEY,                       XK_F10,    setlayout,      {.v = &layouts[12]} },
	{ MODKEY,                       XK_F11,    setlayout,      {.v = &layouts[13]} },
	{ MODKEY|Mod4Mask,              XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_BackSpace,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

