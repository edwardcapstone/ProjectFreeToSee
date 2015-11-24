
F
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113
š
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347
Š
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349
e
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22
I

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103
G
Running DRC with %s threads
24*drc2
42default:defaultZ23-27
L
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461
[
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462
Œ

%s
*constraints2u
aTime (s): cpu = 00:00:00.12 ; elapsed = 00:00:00.12 . Memory (MB): peak = 1085.414 ; gain = 4.0122default:default
X

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103
<
%Done setting XDC timing constraints.
35*timingZ38-35
`

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
B
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49
3
'Phase 1 Retarget | Checksum: 14079d9a8
*common
ˆ

%s
*constraints2q
]Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1480.914 ; gain = 395.5002default:default
l

Phase %s%s
101*constraints2
2 2default:default2(
Constant Propagation2default:defaultZ18-101
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
A
Eliminated %s cells.
10*opt2
402default:defaultZ31-10
?
3Phase 2 Constant Propagation | Checksum: 137b8f703
*common
ˆ

%s
*constraints2q
]Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1480.914 ; gain = 395.5002default:default
]

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101
M
 Eliminated %s unconnected nets.
12*opt2
2132default:defaultZ31-12
N
!Eliminated %s unconnected cells.
11*opt2
1292default:defaultZ31-11
0
$Phase 3 Sweep | Checksum: 1b0fd076f
*common
ˆ

%s
*constraints2q
]Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 1480.914 ; gain = 395.5002default:default
A
5Ending Logic Optimization Task | Checksum: 1b0fd076f
*common
ˆ

%s
*constraints2q
]Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1480.914 ; gain = 395.5002default:default
7
+Implement Debug Cores | Checksum: c6fab317
*common
4
(Logic Optimization | Checksum: c6fab317
*common
X

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103
A
5Ending Power Optimization Task | Checksum: 1b0fd076f
*common
Œ

%s
*constraints2u
aTime (s): cpu = 00:00:00.01 ; elapsed = 00:00:00.02 . Memory (MB): peak = 1480.914 ; gain = 0.0002default:default
Q
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83
½
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
192default:default2
02default:default2
02default:default2
02default:defaultZ4-41
S
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42
û
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
opt_design: 2default:default2
00:00:112default:default2
00:00:112default:default2
1480.9142default:default2
401.5122default:defaultZ17-268
4
Writing XDEF routing.
211*designutilsZ20-211
A
#Writing XDEF routing logical nets.
209*designutilsZ20-209
A
#Writing XDEF routing special nets.
210*designutilsZ20-210
ˆ
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:00.172default:default2
00:00:00.182default:default2
1481.9142default:default2
0.0002default:defaultZ17-268


End Record