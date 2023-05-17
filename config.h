/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "st"
#define TERMCLASS "St"

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const Gap default_gap        = {.isgap = 1, .realgap = 6, .gappx = 6};
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 0;     /* 0 means no systray */
static const int showbar            = 1;     /* 0 means no bar */
static const int topbar             = 1;     /* 0 means bottom bar */
static const char *fonts[]          = { "RobotoMono Nerd Font:size=10", "Material:size=12", "FontAwesome:size=11", "Font Awesome 5 Free:size=11", "Weather Icons:size=10"};
static const char dmenufont[]       = "RobotoMono Nerd Font:size=10";
static unsigned int baralpha        = 0xd0;
static unsigned int borderalpha     = OPAQUE;

static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
      [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
      [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
      [SchemeTitle]  = { selbordercolor, normbgcolor, normbordercolor },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-c", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {TERMINAL, "-n", "spfm", "-g", "144x41", "-e", "nnn", NULL };
const char *spcmd3[] = {TERMINAL, "-n", "spmusic", "-c", "spmusic", "-g", "140x30", "-e", "ncmpcpp-ueberzug", NULL};
// const char *spcmd4[] = {TERMINAL, "-n", "sptrans", "-c", "sptrans", "-g", "140x30", "-e", "terminal-trans.sh", NULL};
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spranger",    spcmd2},
	{"keepassxc",   spcmd3},
	// {"sptrans",		spcmd4},
};

static const XPoint stickyicon[]    = { {0,0}, {4,0}, {4,8}, {2,6}, {0,8}, {0,0} }; /* represents the icon as an array of vertices */
static const XPoint stickyiconbb    = {4,8};	/* defines the bottom right corner of the polygon's bounding box (speeds up scaling) */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class				   instance	            title	            tags mask    isfloating   monitor */
    { "Gimp",					NULL,       	    NULL,       	    0,            1,            -1 },
    { "Firefox",  		        NULL,       	    NULL,       	    1 << 8,       0,            -1 },
    { "Pale moon",  		    NULL,       	    NULL,       	    1 << 8,       0,            -1 },
    { "LibreWolf",  		    NULL,       	    NULL,       	    1 << 8,       0,            -1 },
    { "Tor Browser",  		    NULL,       	    NULL,       	    1 << 7,       0,            -1 },
    { "Nyxt",					NULL,       	    NULL,       	    1 << 8,       0,            -1 },
    { "TelegramDesktop",        NULL,               NULL,               1 << 6,       0,            -1 },
    { "Signal",                 NULL,               NULL,               1 << 6,       0,            -1 },
    { "mpv",                    NULL,               NULL,               1 << 5,       0,            -1 },
    { "tidal-hifi",             "tidal-hifi", 	    "tidal-hifi",       1 << 3,       0,            -1 },
    { "Galculator",             "galculator", 	    "galculator",       0,            1,            -1 },
    { "Gucharmap",              NULL,               NULL,               0,            1,            -1 },
    { "Pale moon",              NULL,               "Pale Moon Preferences",               0,            1,            -1 },
    { "Pale moon",              NULL,               "Software Update",               0,            1,            -1 },
    { "Peek",                   "peek",             NULL,               0,            1,            -1 },
    { "Tk",                     "tk",               NULL,               0,            1,            -1 },
    { "Sxiv",                   NULL,               NULL,               0,            1,            -1 },
    { NULL,						"spterm",			NULL,				SPTAG(0),	  1,            -1 },
    { NULL,		  				"spfm",		    	NULL,		    	SPTAG(1),	  1,            -1 },
    { NULL,		  				"spmusic",	    	"ncmpcpp",			SPTAG(2),	  1,            -1 },
    { NULL,						"sptrans",			NULL,				SPTAG(3),	  1,            -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "horizgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* Default: Master on left, slaves on right */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "###",      horizgrid },
};

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
static const char *dmenucmd[] = { "dmenu_run", "-p", "Command:", NULL };
static const char *roficmd[] = { "rofi", "-show", "run", "-disable-history", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *dwmquit[] = { "dmenu-dwm-quit", NULL};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	/* { "font",               STRING,  &font }, */
	{ "dmenufont",          STRING,  &dmenufont },
	{ "normbgcolor",        STRING,  &normbgcolor },
	{ "normbordercolor",    STRING,  &normbordercolor },
	{ "normfgcolor",        STRING,  &normfgcolor },
	{ "selbgcolor",         STRING,  &selbgcolor },
	{ "selbordercolor",     STRING,  &selbordercolor },
	{ "selfgcolor",         STRING,  &selfgcolor },
	{ "borderpx",          	INTEGER, &borderpx },
	{ "snap",          		INTEGER, &snap },
	{ "showbar",          	INTEGER, &showbar },
	{ "topbar",          	INTEGER, &topbar },
	{ "nmaster",          	INTEGER, &nmaster },
	{ "resizehints",       	INTEGER, &resizehints },
	{ "mfact",      	 	FLOAT,   &mfact },
};


static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = roficmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = +1 } },
	{ MODKEY,						XK_g,	   togglesticky,   {0} },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} }, /* title */
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} }, /* floating */
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} }, /* monocle */
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} }, /* centeredmaster */
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} }, /* centeredfloatingmaster */
	{ MODKEY|ShiftMask,             XK_o,      setlayout,      {.v = &layouts[5]} }, /* centeredfloatingmaster */
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -5 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +5 } },
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = GAP_TOGGLE} },
	{ MODKEY,            		    XK_y,  	   togglescratch,  {.ui = 0 } },
	// { MODKEY,            		    XK_u,      togglescratch,  {.ui = 1 } },
	{ MODKEY,            		    XK_x,      togglescratch,  {.ui = 2 } },
	// { MODKEY,            		    XK_e,      togglescratch,  {.ui = 3 } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      spawn,          {.v = dwmquit } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
