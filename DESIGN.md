# Design

How the enclosure works and why. Every dimension is a setting at the top of [`asic_enclosure.scad`](asic_enclosure.scad). Setting names are given in `code` below.

## Printed parts

| Part | Size (mm) | What it is |
|---|---|---|
| `tube` | 86 × 105 × 140 | The main body: fan pocket, unit shelves and guides, and the power bay. Prints standing on its front edge. |
| `front_frame` | 90 × 88 × 11 | Fan grille. Snaps on and holds the fan. |
| `back_frame` | 79 × 101 × 11 | Snaps on the back. Holds the units in and grips the power board's back corners. |
| `test_slice` | 75 × 99 × 53 | The back of the tube, to check a unit, the board and the back frame. |
| `bay_test_slice` | 75 × 21 × 53 | Only the power bay, to check the board's fit. |
| `back_bay_test_slice` | 79 × 21 × 11 | The bottom strip of the back frame, to use with `bay_test_slice`. It has no snaps, so hold it in place by hand. |
| `front_test_slice` | 86 × 96 × 30 | The fan pocket, to check the fan and the front frame. |
| `av_test` | 62 × 38 × 3 | Six hole sizes for checking how the fan's rubber mounts fit. |

Only the first three are in `stl/`. The rest are optional test prints for checking fit before committing to the 140 mm tube. To export one, run:

```bash
openscad --backend=manifold -o test_slice.stl -D 'part="test_slice"' asic_enclosure.scad
```

## Airflow

- **Closed duct.** The units stack flat in a duct that's closed on all four sides. All of the fan's air goes between the units, not around them.
- **Plenum.** There's a 12 mm gap between the fan and the units (`plenum`), so air spreads out past the fan's hub before it reaches them.
- **Channel sizes.** The gaps between units are 7 mm (`gap_inner`). The gaps above the top unit and below the bottom unit are 5 mm (`gap_outer`). The middle unit has a hot neighbour on both sides, so it gets wider channels.
- **Side ducts.** The units take air in through slits in their front faces and have vents in their sides. The 4.5 mm gap beside each unit is a separate duct:
  - **Front:** closed by the front guide.
  - **Top:** closed by a lip along the unit's top edge.
  - **Back:** open to the room.

  That puts nearly the fan's full pressure across each unit, front slits to side vents.

## Fan

- **Pocket:** 0.7 mm clearance per side (`fan_clear`) and 1 mm extra depth (`fan_depth_clear`). Less clearance than that was too tight for the NF-A8.
- **Cable:** goes down through a 16 × 10 mm hole in the pocket floor and runs back through the power bay. The hole is big enough for a 4-pin plug. It sits under where the NF-A8's wire leaves the fan, in the bottom-left corner seen from the front (`fan_cable_side`, `fan_cable_x`).
- **Rubber mounts:** Noctua's NA-AV1 mounts are made for a thin steel panel. Each mount goes through a 6.8 mm hole (`fan_hole_d`) in a 13 mm recess that thins the plate to 1.2 mm (`av_panel_t`). These sizes came from `av_test` prints.
- **Screws instead:** the holes are too big for a fan screw's head on its own, so put an M3 or #4 washer under each one.

## Units

- **Front to back:** stops at the front of the shelves and tabs on the back frame. The tabs cover 6 mm of each unit's back edge, clear of the ports.
- **Side to side, and up and down:** a block at the front and a low rib at the back (2 × 6 mm, `side_rib_t`, `side_rib_h`), the shelf below, and the lip above.
  - **Clearance:** 0 mm nominal at the sides (`guide_side_clear`), which prints as a snug slide. 0.5 mm above (`guide_top_clear`).
  - **Why the rib is low:** it leaves the side duct's outlet open above it.
- **Rubber feet:** the units' feet hang below the shelves, so units sit at the same height with or without them.
- **One-way frames:** each frame has a tooth that only fits a notch in the tube's top wall. Upside down, the frame won't seat.

## Power

- **Separate bay.** The power board sits in a bay under the duct, with the duct floor between them. If the bay were open to the duct, it would take most of the fan's air, and loose cables could sag into the bottom channel.
- **Holding the board.**
  - **Rails:** the board slides in from the back on two floor rails under its side edges.
  - **Lips:** a lip on each rail stops the board shifting sideways.
  - **Corners:** it's gripped above and below only at its four corners, which have no parts on them. The front stops grip the front corners, and the back frame's jaws grip the back corners.
- **Cooling.** The board puts out roughly 2–3 W at full load.
  - **Bleed slots:** two slots in the duct floor (`bleed_slots`) let a little of the fan's air into the bay.
  - **Exits:** the air leaves through the barrel jack opening and the cable notch.
  - **Side vents:** there are also vents in the bay's side walls.
- **Current.** All three units share one USB-A output rated 3.4 A, which is about 1.1 A per unit.
  - **Check:** measure your units' draw at the settings you'll run.
  - **If they need more:** use a second splitter on the other output.
- **Other boards.** If your board's size or layout is different, adjust these settings:
  - `board_w`, `board_d`, `board_t`: the board's outline and thickness.
  - `grip_w`, `grip_d`: the corner grip zones.
  - `under_gap`, `over_h`: the room below and above the board.
  - `jack_x`, `jack_win_w`: the barrel jack opening.
