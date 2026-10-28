// Fan-ducted enclosure for three ASIC timelord units stacked flat, with a
// power bay underneath for a dual USB-A step-down module.
//
// Coordinates (as assembled): X is width (centred), Y runs front (fan, y=0)
// to back (USB-C ports), Z is up with the duct's floor at z=0; the power bay
// sits below that floor.
// Every part is exported already rotated into its supportless print
// orientation; use part="assembly" to preview everything together.

/* [Part] */
part = "assembly"; // [assembly, tube, front_frame, back_frame, test_slice, bay_test_slice, back_bay_test_slice, front_test_slice, av_test]

/* [Units] */
unit_w = 61;
unit_h = 17.2;
unit_d = 95.5;
// Unit side to tube wall, including clearance.
side_gap = 4.5;
// Floor and ceiling air channels.
gap_outer = 5;
// Channels between units; wider because both of their walls are hot.
gap_inner = 7;
unit_end_clear = 0.5;

/* [Shell] */
wall = 2.4;
shelf_t = 2;
// How far each shelf reaches under a unit's side edge.
shelf_overlap = 3;
stop_h = 5;
stop_len = 3;
// Guides at both ends of each unit's side edges stop it moving sideways or lifting.
guide_len = 10;
// Nominal gap per side. The first test slice at 0.4 had ~0.9 mm total play,
// so the print runs slightly loose and 0 gives a snug slide.
guide_side_clear = 0;
guide_top_clear = 0.5;
guide_lip_t = 2;
guide_lead = 2;
// The side gaps double as exhaust ducts for the units' side vents: closed at
// the front, closed above by a full-length lip, and open at the back. At the
// back the guide is only a low rib against the unit's side, so the duct's
// outlet stays open above it.
side_rib_t = 2;
side_rib_h = 6;
// Free air between the end of the taper and the unit fronts.
plenum = 12;
taper_len = 6;

/* [Fan] */
fan_size = 80;
fan_depth = 25;
fan_hole_spacing = 71.5;
// Fan mounting holes. Noctua's NA-AV1 rubber mounts are made for a thin case
// panel, so the plate is thinned to av_panel_t around each hole, from the
// outside, with room for the mount's head. Standard fan screws fit too.
// Picked from av_test prints: 6.8 mm holes on 1.2 mm plate fit the NA-AV1
// best; its head measures 11.9 mm.
fan_hole_d = 6.8;
av_panel_t = 1.2;
av_head_d = 13;
// Total clearance across the pocket; 0.6 was too tight for a Noctua NF-A8.
fan_clear = 1.4;
// Extra pocket depth beyond the fan's 25 mm (room for its corner pads).
fan_depth_clear = 1.0;
fan_opening_d = 76;
// Thickness of the front frame's grille plate.
plate_t = 3;
// Which bottom corner the fan's cable leaves from: 1 = right, -1 = left, seen
// from the front. Left keeps it on the opposite side of the bay from the
// splitter's leads.
fan_cable_side = -1; // [-1, 1]
// The cable leaves the fan 14 mm in from the bottom mounting hole, measured
// toward the centre; this is that point's distance from the fan's centre line.
fan_cable_x = fan_hole_spacing / 2 - 14;

/* [Power bay] */
// Dual USB-A step-down module (6-32 V in, 5 V out): barrel jack on the back
// edge, two USB-A outputs on the front edge.
board_w = 50;
board_d = 40;
board_t = 1.6;
// Clearance along the board's length and across its width.
board_len_clear = 0.3;
board_side_clear = 0.5;
// Under the board: room for the pins on its underside.
under_gap = 4;
// Above the board: the barrel jack is the tallest part.
over_h = 11;
// Floor rails under the board's side edges: how far they reach in under the
// edge and out beyond it.
rail_in = 1.5;
rail_out = 1.5;
// Lips along the rails' outer edges, beside the board's side edges and
// board_side_clear away from them, so it can't swing sideways before the back
// frame is on. They stand as high as the front stops and never reach over the
// board, so they can't touch its parts.
rail_lip_t = 1.6;
// Corner grips: how far in from the side edge and along it they reach. The
// corners carry the module's mounting holes, so they are free of parts.
grip_w = 3.5;
grip_d = 4;
grip_jaw = 1.5;
grip_gap = 0.4;
// Opening in the back frame for the barrel jack: centre offset from the
// middle (seen from the front) and width.
jack_x = 0;
jack_win_w = 14;
// Notch in the back frame for the USB-C splitter's leads, on the units'
// power-port side (1 = right seen from the front, i.e. left seen from the back).
cable_side = 1; // [-1, 1]
cable_notch_w = 8;
// Slots in the duct floor above the board let a little of the fan's air run
// through the bay to cool the converter; 0 turns them off.
bleed_slots = 2;
bleed_slot_w = 20;
bleed_slot_l = 2;
// Hole in the fan pocket floor for the fan cable; fits a 4-pin fan plug.
fan_hole_w = 16;
fan_hole_l = 10;

/* [Front and back frames] */
frame_t = 3;
skirt_t = 1.8;
skirt_depth = 8;
skirt_clear = 0.2;
// How far the tabs reach onto each unit's back face (units have ~9 mm of border).
tab_overlap = 6;
snap_depth = 0.9;
// A tooth on each frame fits a notch in the tube's top wall. Upside down it
// lands on solid bottom wall, so the frame can't seat and the snaps won't click.
key_x = 22;
key_w = 8;
key_depth = 3;

/* [Hidden] */
$fn = 96;
eps = 0.01;

in_w = unit_w + 2 * side_gap;
in_h = 3 * unit_h + 2 * gap_outer + 2 * gap_inner;
out_w = in_w + 2 * wall;
out_h = in_h + 2 * wall;
pocket = fan_size + fan_clear;
box = pocket + 2 * wall;
box_len = fan_depth + fan_depth_clear;
tube_start = box_len + taper_len;
unit_front = tube_start + plenum;
tube_end = unit_front + unit_d + unit_end_clear;
fan_cz = wall + pocket / 2;

bay_h = under_gap + board_t + over_h;
board_stop_h = under_gap + board_t + grip_gap + grip_jaw;
test_y0 = floor(tube_end - board_len_clear - board_d - 3 - board_stop_h - 2);
bay_bottom = -bay_h - wall;
board_z = -bay_h + under_gap;
board_hw = board_w / 2;
// The board's front corners stop against the grips at board_stop; its back
// edge then sits just inside the back frame.
board_stop = tube_end - board_len_clear - board_d;

// Snap bumps on each frame ramp up from *_y0 to a catch at *_y1.
snap_y0 = tube_end - 6.5;
snap_y1 = tube_end - 3.5;
side_snap_z = unit_z(1) + unit_h / 2;
front_snap_y0 = 6.5;
front_snap_y1 = 3.5;

function unit_z(i) = wall + gap_outer + i * (unit_h + gap_inner);

// Extrude a profile drawn in the XZ plane along +Y from y=0 to y=len.
module along_y(len) {
    translate([0, len, 0]) rotate([90, 0, 0]) linear_extrude(len) children();
}

// ---------------------------------------------------------------- tube

module tube_outer() {
    translate([-box / 2, 0, 0]) cube([box, box_len, box]);
    hull() {
        translate([-box / 2, box_len - eps, 0]) cube([box, eps, box]);
        translate([-out_w / 2, tube_start, 0]) cube([out_w, eps, out_h]);
    }
    translate([-out_w / 2, tube_start, 0]) cube([out_w, tube_end - tube_start, out_h]);
}

module tube_inner() {
    // The fan slides into this pocket from the front; the taper behind it is the stop.
    translate([-pocket / 2, -1, wall]) cube([pocket, box_len + 1 + eps, pocket]);
    hull() {
        translate([-pocket / 2, box_len, wall]) cube([pocket, eps, pocket]);
        translate([-in_w / 2, tube_start, wall]) cube([in_w, eps, in_h]);
    }
    translate([-in_w / 2, tube_start, wall]) cube([in_w, tube_end - tube_start + 1, in_h]);
}

module fan_grille_cut() {
    difference() {
        translate([0, -plate_t - 1, fan_cz]) rotate([-90, 0, 0]) cylinder(d = fan_opening_d, h = plate_t + 2);
        for (r = [14, 26])
            translate([0, -plate_t - 2, fan_cz]) rotate([-90, 0, 0]) difference() {
                cylinder(r = r + 0.8, h = plate_t + 4);
                translate([0, 0, -1]) cylinder(r = r - 0.8, h = plate_t + 6);
            }
        for (a = [45, 135])
            translate([0, -plate_t / 2, fan_cz]) rotate([0, a, 0])
                cube([fan_opening_d + 2, plate_t + 4, 2], center = true);
    }
}

module fan_holes() {
    for (sx = [-1, 1], sz = [-1, 1])
        translate([sx * fan_hole_spacing / 2, -plate_t - 1, fan_cz + sz * fan_hole_spacing / 2])
            rotate([-90, 0, 0]) {
                cylinder(d = fan_hole_d, h = plate_t + 2);
                cylinder(d = av_head_d, h = 1 + plate_t - av_panel_t);
            }
}

// The fan's lead leaves from its exhaust side, at the back of the pocket, and
// drops through the pocket floor into the power bay.
module fan_cable_hole() {
    x0 = fan_cable_side * fan_cable_x - fan_hole_w / 2;
    translate([x0, box_len - 1 - fan_hole_l, -1]) cube([fan_hole_w, fan_hole_l, wall + 2]);
}

module snap_windows() {
    wy0 = snap_y0 - 0.3;
    wy1 = snap_y1 + 0.3;
    translate([-11, wy0, out_h - wall - 1]) cube([22, wy1 - wy0, wall + 2]);
    for (m = [0, 1]) mirror([m, 0, 0])
        translate([out_w / 2 - wall - 1, wy0, side_snap_z - 5.5]) cube([wall + 2, wy1 - wy0, 11]);
}

module key_notch() {
    translate([key_x - key_w / 2, tube_end - key_depth, out_h - wall - 1]) cube([key_w, key_depth + 1, wall + 2]);
}

module front_snap_windows() {
    wy0 = front_snap_y1 - 0.3;
    wy1 = front_snap_y0 + 0.3;
    translate([-11, wy0, box - wall - 1]) cube([22, wy1 - wy0, wall + 2]);
    for (m = [0, 1]) mirror([m, 0, 0])
        translate([box / 2 - wall - 1, wy0, fan_cz - 5.5]) cube([wall + 2, wy1 - wy0, 11]);
}

module front_key_notch() {
    translate([key_x - key_w / 2, -1, box - wall - 1]) cube([key_w, key_depth + 1, wall + 2]);
}

// The power bay runs the full length under the duct floor, closed at the
// front and open at the back where the back frame covers it.
module bay_outer() {
    translate([-out_w / 2, 0, bay_bottom]) cube([out_w, tube_end, -bay_bottom + eps]);
}

module bay_inner() {
    translate([-in_w / 2, wall, -bay_h]) cube([in_w, tube_end - wall + 1, bay_h]);
}

// A block standing on the bay floor, with a 45 degree underside at its front
// end so it prints without support (the tube prints front-down).
module floor_block(x0, x1, y0, y1, z1) {
    hull() {
        translate([x0, y0, -bay_h - eps]) cube([x1 - x0, y1 - y0, z1 + bay_h + eps]);
        translate([x0, y0 - (z1 + bay_h), -bay_h - eps]) cube([x1 - x0, eps, eps]);
    }
}

// Two floor rails carry the board by its side edges, leaving the space beside
// it free for cables. Stops on their front ends grip the front corners from
// above and below; the back frame grips the back corners, so the rails stop
// short of them.
module board_supports() {
    x_in = board_hw - grip_w;
    x_out = board_hw + rail_out;
    slot_top = board_z + board_t + grip_gap;
    stop_y0 = board_stop - 3;
    for (m = [0, 1]) mirror([m, 0, 0]) {
        floor_block(board_hw - rail_in, x_out, stop_y0, tube_end - grip_d - 0.5, board_z);
        lip_x0 = board_hw + board_side_clear;
        lip_y1 = tube_end - grip_d - 0.5;
        difference() {
            floor_block(lip_x0, lip_x0 + rail_lip_t, stop_y0, lip_y1, slot_top + grip_jaw);
            // Flare at the back end to guide the board in.
            hull() {
                translate([lip_x0 - 1, lip_y1, board_z + eps]) cube([1.8, eps, slot_top + grip_jaw - board_z]);
                translate([lip_x0 - 1, lip_y1 - 3, board_z + eps]) cube([1, eps, slot_top + grip_jaw - board_z]);
            }
        }
        difference() {
            floor_block(x_in, x_out, stop_y0, board_stop + grip_d, slot_top + grip_jaw);
            translate([x_in - 1, board_stop, board_z]) cube([board_hw + board_side_clear - x_in + 1, grip_d + 1, slot_top - board_z]);
            // Lead-in on the upper jaw.
            hull() {
                translate([x_in - 1, board_stop + grip_d - 1, slot_top - eps]) cube([board_hw + board_side_clear - x_in + 1, eps, eps]);
                translate([x_in - 1, board_stop + grip_d + eps, slot_top - eps]) cube([board_hw + board_side_clear - x_in + 1, eps, 0.8]);
            }
        }
    }
}

// The converter makes a few watts of heat: vents in the bay walls beside it,
// and a little air bled down from the duct through slots above it.
module bay_vents() {
    for (k = [0 : 2], m = [0, 1]) mirror([m, 0, 0])
        translate([in_w / 2 - 1, board_stop + 6 + k * 12, board_z - 1]) cube([wall + 2, 3, 8]);
    for (k = [0 : bleed_slots - 1])
        translate([-bleed_slot_w / 2, board_stop + 10 + k * 18, -1]) cube([bleed_slot_w, bleed_slot_l, wall + 1 + eps]);
}

module shelves() {
    x_wall = in_w / 2;
    x_in = in_w / 2 - side_gap - shelf_overlap;
    for (i = [0 : 2], m = [0, 1]) mirror([m, 0, 0]) {
        z = unit_z(i);
        translate([x_in, unit_front - stop_len, z - shelf_t])
            cube([x_wall - x_in + 0.5, tube_end - unit_front + stop_len, shelf_t]);
        // Front stop, with a 45 degree underside so it prints without support.
        hull() {
            translate([x_in, unit_front - stop_len, z - shelf_t])
                cube([x_wall - x_in + 0.5, stop_len, shelf_t + stop_h]);
            translate([x_wall, unit_front - stop_len - (x_wall - x_in), z - shelf_t])
                cube([0.5, eps, shelf_t + stop_h]);
        }
    }
}

// One guide piece against the wall, with a 45 degree underside for printing
// and a lead-in at its back end (lead = [x, z] inset) to steer units in.
module guide_piece(x0, x1, z0, z1, y0, y1, lead) {
    hull() {
        translate([x1, y0 - (x1 - x0), z0]) cube([0.5, eps, z1 - z0]);
        translate([x0, y0, z0]) cube([x1 - x0 + 0.5, y1 - y0 - guide_lead, z1 - z0]);
        translate([x0 + lead[0], y1 - eps, z0 + lead[1]]) cube([x1 - x0 + 0.5 - lead[0], eps, z1 - z0 - lead[1]]);
    }
}

// The guides box each unit's side edge in: the shelf below, a lip over the
// top edge along the full length, a block filling the side gap at the front,
// and a low rib against the unit's side at the back. The side gap between
// them is a duct from the unit's side vents out the back.
module guides() {
    x_wall = in_w / 2;
    x_side = unit_w / 2 + guide_side_clear;
    x_lip = in_w / 2 - side_gap - shelf_overlap;
    y0 = unit_front - stop_len;
    for (i = [0 : 2], m = [0, 1]) mirror([m, 0, 0]) {
        z = unit_z(i);
        z_lip = z + unit_h + guide_top_clear;
        guide_piece(x_side, x_wall, z, z_lip + guide_lip_t, y0, unit_front + guide_len, [1.5, 0]);
        guide_piece(x_lip, x_wall, z_lip, z_lip + guide_lip_t, y0, tube_end, [0, 1]);
        // Back rib, with a 45 degree underside down to the shelf and a lead-in.
        y1 = tube_end;
        hull() {
            translate([x_side, y1 - guide_len, z - eps]) cube([side_rib_t, guide_len - guide_lead, side_rib_h + eps]);
            translate([x_side, y1 - guide_len - side_rib_h, z - eps]) cube([side_rib_t, eps, eps]);
            translate([x_side + 1.5, y1 - eps, z - eps]) cube([side_rib_t - 1.5, eps, side_rib_h + eps]);
        }
    }
}

module tube() {
    difference() {
        union() {
            difference() {
                union() {
                    tube_outer();
                    bay_outer();
                }
                tube_inner();
                bay_inner();
                bay_vents();
                fan_cable_hole();
                front_snap_windows();
                front_key_notch();
            }
            shelves();
            guides();
            board_supports();
        }
        snap_windows();
        key_notch();
    }
}

// ---------------------------------------------------------- back frame

module back_frame() {
    fw = out_w / 2 + skirt_clear + skirt_t;
    fh = out_h + skirt_clear + skirt_t;
    xs = out_w / 2 + skirt_clear;
    zs = out_h + skirt_clear;
    difference() {
        union() {
            translate([-fw, tube_end, bay_bottom]) cube([2 * fw, frame_t, fh - bay_bottom]);
            translate([-fw, tube_end - skirt_depth, zs]) cube([2 * fw, skirt_depth + eps, skirt_t]);
            for (m = [0, 1]) mirror([m, 0, 0])
                translate([xs, tube_end - skirt_depth, bay_bottom])
                    cube([skirt_t, skirt_depth + eps, fh - bay_bottom]);
            kc = 0.2;
            translate([key_x - key_w / 2 + kc, tube_end - key_depth + kc, out_h - wall + kc])
                cube([key_w - 2 * kc, key_depth - kc + eps, wall - kc + skirt_clear + eps]);
        }
        translate([-in_w / 2, tube_end - 1, wall]) cube([in_w, frame_t + 2, in_h]);
        // Opening for the barrel jack.
        translate([jack_x - jack_win_w / 2, tube_end - 1, board_z + board_t - 0.5]) cube([jack_win_w, frame_t + 2, over_h]);
        // Notch for the splitter's leads, open at the bottom edge so the cables
        // slip into it as the frame goes on.
        translate([cable_side > 0 ? in_w / 2 - 0.5 - cable_notch_w : -in_w / 2 + 0.5, tube_end - 1, bay_bottom - 1])
            cube([cable_notch_w, frame_t + 2, -bay_bottom]);
    }
    // Grips over and under the module's back corners, with a lead-in on each jaw.
    for (m = [0, 1]) mirror([m, 0, 0]) {
        x_in = board_hw - grip_w;
        x_out = board_hw + rail_out;
        slot_top = board_z + board_t + grip_gap;
        for (jaw = [[board_z - grip_jaw, board_z, 1], [slot_top, slot_top + grip_jaw, -1]]) hull() {
            translate([x_in, tube_end - grip_d + 0.8, jaw[0]]) cube([x_out - x_in, grip_d - 0.8 + eps, jaw[1] - jaw[0]]);
            translate([x_in, tube_end - grip_d, jaw[2] > 0 ? jaw[0] : jaw[0] + 0.8])
                cube([x_out - x_in, eps, jaw[1] - jaw[0] - 0.8]);
        }
        // Beside the board edge: keeps it from shifting sideways at the back.
        translate([board_hw + board_side_clear, tube_end - grip_d, board_z - grip_jaw])
            cube([x_out - board_hw - board_side_clear, grip_d + eps, slot_top + grip_jaw - board_z + grip_jaw]);
    }
    // Tabs over each unit's back edge. Each hangs from the side of the opening
    // by a short arm behind the guide rib, leaving the side duct's outlet open.
    for (i = [0 : 2], m = [0, 1]) mirror([m, 0, 0]) {
        x_side = unit_w / 2 + guide_side_clear;
        x_in = x_side - tab_overlap;
        z = unit_z(i);
        translate([x_in, tube_end, z + 1]) cube([x_side - x_in, frame_t, unit_h - 4]);
        translate([x_side - eps, tube_end, z + 1]) cube([in_w / 2 - x_side + 2 * eps, frame_t, side_rib_h - 1]);
    }
    hull() {
        translate([-10, snap_y0, zs - eps]) cube([20, eps, 0.2]);
        translate([-10, snap_y1 - eps, zs - snap_depth]) cube([20, eps, snap_depth + 0.2]);
    }
    for (m = [0, 1]) mirror([m, 0, 0]) hull() {
        translate([xs - eps, snap_y0, side_snap_z - 5]) cube([0.2, eps, 10]);
        translate([xs - snap_depth, snap_y1 - eps, side_snap_z - 5]) cube([snap_depth + 0.2, eps, 10]);
    }
}

// --------------------------------------------------------- front frame

// Grille plate that snaps over the fan housing and holds the fan in its
// pocket. The fan's own screws go through the plate into the fan.
module front_frame() {
    fw = box / 2 + skirt_clear + skirt_t;
    fh = box + skirt_clear + skirt_t;
    xs = box / 2 + skirt_clear;
    zs = box + skirt_clear;
    kc = 0.2;
    difference() {
        union() {
            translate([-fw, -plate_t, 0]) cube([2 * fw, plate_t, fh]);
            translate([-fw, -eps, zs]) cube([2 * fw, skirt_depth + eps, skirt_t]);
            for (m = [0, 1]) mirror([m, 0, 0])
                translate([xs, -eps, 0]) cube([skirt_t, skirt_depth + eps, fh]);
            translate([key_x - key_w / 2 + kc, -eps, box - wall + kc])
                cube([key_w - 2 * kc, key_depth - kc + eps, wall - kc + skirt_clear + eps]);
        }
        fan_grille_cut();
        fan_holes();
    }
    hull() {
        translate([-10, front_snap_y0, zs - eps]) cube([20, eps, 0.2]);
        translate([-10, front_snap_y1, zs - snap_depth]) cube([20, eps, snap_depth + 0.2]);
    }
    for (m = [0, 1]) mirror([m, 0, 0]) hull() {
        translate([xs - eps, front_snap_y0, fan_cz - 5]) cube([0.2, eps, 10]);
        translate([xs - snap_depth, front_snap_y1, fan_cz - 5]) cube([snap_depth + 0.2, eps, 10]);
    }
}

// ----------------------------------------------------------- mount test

// Six thinned holes to try an NA-AV1 mount in: rows are panel thickness, columns
// hole diameter. Prints outer face down, like the front frame.
av_test_holes = [6.2, 6.5, 6.8];
av_test_panels = [1.2, 1.4];

function mm_label(v) = v == floor(v) ? str(v, ".0") : str(v);

module av_test() {
    pitch = av_head_d + 3;
    w = len(av_test_holes) * pitch + 14;
    h = len(av_test_panels) * pitch + 6;
    difference() {
        cube([w, h, plate_t]);
        for (i = [0 : len(av_test_holes) - 1], j = [0 : len(av_test_panels) - 1])
            translate([12 + pitch / 2 + i * pitch, 3 + pitch / 2 + j * pitch, -1]) {
                cylinder(d = av_test_holes[i], h = plate_t + 2);
                cylinder(d = av_head_d, h = 1 + plate_t - av_test_panels[j]);
            }
        for (i = [0 : len(av_test_holes) - 1])
            translate([12 + pitch / 2 + i * pitch, h - 0.2, plate_t - 0.6])
                linear_extrude(1) text(mm_label(av_test_holes[i]), size = 2.5, halign = "center", valign = "top");
        for (j = [0 : len(av_test_panels) - 1])
            translate([1.5, 3 + pitch / 2 + j * pitch, plate_t - 0.6])
                linear_extrude(1) text(mm_label(av_test_panels[j]), size = 2.5, valign = "center");
    }
}

// ------------------------------------------------------------- preview

module ghost_units() {
    for (i = [0 : 2])
        translate([-unit_w / 2, unit_front, unit_z(i)]) cube([unit_w, unit_d, unit_h]);
    translate([-fan_size / 2, 0, fan_cz - fan_size / 2]) cube([fan_size, fan_depth, fan_size]);
    hub_module();
}

// Rough stand-in for the step-down module: board, barrel jack on the back
// edge, two USB-A outputs on the front edge. Part positions are guesses.
module hub_module() {
    y0 = board_stop;
    translate([-board_hw, y0, board_z]) cube([board_w, board_d, board_t]);
    translate([jack_x - 4.5, y0 + board_d - 14, board_z + board_t]) cube([9, 14, 9.5]);
    for (x = [-board_hw + 6, board_hw - 19.5])
        translate([x, y0, board_z + board_t]) cube([13.5, 14, 7]);
    for (x = [-board_hw + 9, board_hw - 21])
        translate([x, y0 + 15, board_z + board_t]) cube([12, 12, 5]);
}

module assembly() {
    color("SlateGray") tube();
    color("DarkOrange") front_frame();
    color("DarkOrange") back_frame();
    %ghost_units();
}

if (part == "assembly") assembly();
else if (part == "tube") rotate([90, 0, 0]) tube();
else if (part == "front_frame") translate([0, 0, plate_t]) rotate([90, 0, 0]) front_frame();
else if (part == "av_test") av_test();
else if (part == "back_frame") translate([0, 0, tube_end + frame_t]) rotate([-90, 0, 0]) back_frame();
// The back of the tube, long enough to include the bay's front stops: checks
// the unit guides, the module's fit and the back frame.
else if (part == "test_slice")
    translate([0, 0, -test_y0]) rotate([90, 0, 0]) intersection() {
        tube();
        translate([-100, test_y0, -100]) cube([200, tube_end - test_y0, 300]);
    }
// Only the power bay and the duct floor over it, over the same length as
// test_slice: checks the board on its rails and in the front stops.
else if (part == "bay_test_slice")
    translate([0, 0, -test_y0]) rotate([90, 0, 0]) intersection() {
        tube();
        translate([-100, test_y0, bay_bottom - 1]) cube([200, tube_end - test_y0, wall - bay_bottom + 1]);
    }
// The matching bottom strip of the back frame: checks the jaws on the board's
// back corners, the barrel jack opening and the cable notch. It has no snaps,
// so hold it against bay_test_slice.
else if (part == "back_bay_test_slice")
    translate([0, 0, tube_end + frame_t]) rotate([-90, 0, 0]) intersection() {
        back_frame();
        translate([-100, tube_end - 50, bay_bottom - 1]) cube([200, 100, wall - bay_bottom + 1]);
    }
// The fan pocket plus the start of the taper: checks the fan fit and the front snaps.
else if (part == "front_test_slice")
    rotate([90, 0, 0]) intersection() {
        tube();
        translate([-100, -1, -10]) cube([200, box_len + 4 + 1, 200]);
    }
