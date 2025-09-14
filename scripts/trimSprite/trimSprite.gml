function sprite_trim(_spr) {
    var w = sprite_get_width(_spr);
    var h = sprite_get_height(_spr);

    // Force precise bounding box
    sprite_collision_mask(_spr, true, bboxmode_automatic, 0, 0, 0, 0, bboxkind_precise, 0);

    var offsets = 0;
    var new_spr = -1;

    var l = sprite_get_bbox_left(_spr);
    var t = sprite_get_bbox_top(_spr);
    var r = sprite_get_bbox_right(_spr);
    var b = sprite_get_bbox_bottom(_spr);

    var crop_w = r - l + 1;
    var crop_h = b - t + 1;

    // Create surface for cropping
    var surf = surface_create(crop_w, crop_h);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(_spr, 0, -l, -t); // offset to crop
    surface_reset_target();

    var frame_spr = sprite_create_from_surface(surf, 0, 0, crop_w, crop_h, false, false, 0, 0);
    surface_free(surf);

    new_spr = frame_spr;

    offsets = { x: l, y: t };

    return { sprite: new_spr, offsets: offsets };
}