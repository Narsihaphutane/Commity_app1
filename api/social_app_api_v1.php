<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
if (!isset($_SESSION)) {
    session_start();
}
if (!isset($conn)) {
    require_once "../../config/connection.php";
}
function respond($success, $data = [], $code = 200, $msg = '') {
    http_response_code($code);
    echo json_encode([
        'success' => $success,
        'message' => $msg,
        'data' => $data
    ]);
    exit;
}
$input = json_decode(file_get_contents('php://input'), true) ?? $_POST;
$action = $input['action'] ?? '';
//$_SESSION['vendor_id'] = 2;
if (!isset($_SESSION['vendor_id'])) {
    errorResponse("Unauthorized", 401);
}
$vendor_id = $_SESSION['vendor_id'];
$site_id = $this_site_id;
if ($action === 'get_interests') {

    $site_id = $this_site_id;
    $qry = "SELECT id, title, type
            FROM skills 
            WHERE site_id = '" . mysqli_real_escape_string($conn, $site_id) . "' 
              AND status = 1
              AND type = 'Interest'
            ORDER BY title";

    $res = mysqli_query($conn, $qry);

    if (!$res) {
        respond(false, [], 500, "Failed to fetch interests");
    }

    $skills = mysqli_fetch_all($res, MYSQLI_ASSOC);

    respond(true, $skills, 200, "Interests fetched successfully");
}
if ($action === 'add_interest') {

    $site_id     = $this_site_id;
    $title       = $input['title'] ?? '';
    $type        = 'Interest';

    if (empty($title) || empty($type)) {
        respond(false, [], 400, "Required fields missing");
    }

    $qry = "INSERT INTO skills (site_id, type, title, created_date, status) 
            VALUES (
                '" . mysqli_real_escape_string($conn, $site_id) . "',
                '" . mysqli_real_escape_string($conn, $type) . "',
                '" . mysqli_real_escape_string($conn, $title) . "',
                NOW(),
                1
            )";

    $res = mysqli_query($conn, $qry);

    if (!$res) {
        respond(false, [], 500, "Failed to add interest");
    }

    $new_id = mysqli_insert_id($conn);

    respond(true, ['id' => $new_id], 200, "Interest added successfully");
}
if ($action === 'save_user_interests') {

    $interests = $input['interests'] ?? [];

    if (empty($vendor_id)) {
        respond(false, [], 401, "Unauthorized");
    }

    if (!is_array($interests) || count($interests) === 0) {
        respond(false, [], 400, "No interests selected");
    }

    $values = [];
    foreach ($interests as $interest_id) {
        $interest_id = intval($interest_id);
        if ($interest_id > 0) {
            $values[] = "(
                '" . mysqli_real_escape_string($conn, $site_id) . "',
                '" . mysqli_real_escape_string($conn, $vendor_id) . "',
                '" . mysqli_real_escape_string($conn, $interest_id) . "',
                NOW()
            )";
        }
    }

    if (empty($values)) {
        respond(false, [], 400, "No valid interests to save");
    }

    // Optional: Delete existing interests for this vendor before inserting
    $del_qry = "DELETE FROM user_interests 
                WHERE vendor_id = '" . mysqli_real_escape_string($conn, $vendor_id) . "' 
                  AND site_id = '" . mysqli_real_escape_string($conn, $site_id) . "'";
    mysqli_query($conn, $del_qry);

    $qry = "INSERT INTO user_interests (site_id, vendor_id, interest_id, created_date) VALUES " . implode(",", $values);
    $res = mysqli_query($conn, $qry);

    if (!$res) {
        respond(false, [], 500, "Failed to save user interests");
    }

    respond(true, [], 200, "User interests saved successfully");
}
if ($action === 'create_post') {

    $vendor_id = $_SESSION['vendor_id'] ?? 0;
    $site_id   = $this_site_id;
    $curr_date = date('Y-m-d H:i:s');

    // Required fields from input
    $content_type = $input['content_type'] ?? '';
    $visibility   = $input['visibility'] ?? 'public';
    $label        = $input['label'] ?? '';
    $tags         = $input['tags'] ?? '';
    $location     = $input['location'] ?? '';

    if (empty($vendor_id) || empty($content_type)) {
        respond(false, [], 400, "Vendor ID or content type missing");
    }

    // Insert post into post_content
    $qry = "INSERT INTO post_content 
            (site_id, vendor_id, content_type, visibility, label, tags, location, created_date) 
            VALUES (
                '" . mysqli_real_escape_string($conn, $site_id) . "',
                '" . mysqli_real_escape_string($conn, $vendor_id) . "',
                '" . mysqli_real_escape_string($conn, $content_type) . "',
                '" . mysqli_real_escape_string($conn, $visibility) . "',
                '" . mysqli_real_escape_string($conn, $label) . "',
                '" . mysqli_real_escape_string($conn, $tags) . "',
                '" . mysqli_real_escape_string($conn, $location) . "',
                '" . $curr_date . "'
            )";

    $res = mysqli_query($conn, $qry);

    if (!$res) {
        respond(false, [], 500, "Failed to create post");
    }

    $post_id = mysqli_insert_id($conn);
    $uploadedImageLinks = [];

    // Save images
    $breaker = intval($input['image_count'] ?? 0);
    for ($imgi = 1; $imgi <= $breaker; $imgi++) {
        if (isset($_FILES['postImage' . $imgi]['tmp_name']) && $_FILES['postImage' . $imgi]['tmp_name'] != '') {
            $main_image_url = getURL($_FILES['postImage' . $imgi]['tmp_name']);
            $uploadedImageLinks['postImage' . $imgi] = $main_image_url;

            $img_qry = "INSERT INTO product_images 
                        (marketplace_id, main, product_id, type, image_url, created_date, variant_id) 
                        VALUES (
                            6, 0, '" . intval($post_id) . "', 'POSTS', '" . mysqli_real_escape_string($conn, $main_image_url) . "', '" . $curr_date . "', 0
                        )";
            if (!mysqli_query($conn, $img_qry)) errlog(mysqli_error($conn), $img_qry);

        } else if (isset($input['altpostImage' . $imgi])) {
            if (isset($uploadedImageLinks[$input['altpostImage' . $imgi]])) {
                $main_image_url = $uploadedImageLinks[$input['altpostImage' . $imgi]];
                $uploadedImageLinks['postImage' . $imgi] = $main_image_url;

                $img_qry = "INSERT INTO product_images 
                            (marketplace_id, main, product_id, type, image_url, created_date, variant_id) 
                            VALUES (
                                6, 0, '" . intval($post_id) . "', 'POSTS', '" . mysqli_real_escape_string($conn, $main_image_url) . "', '" . $curr_date . "', 0
                            )";
                if (!mysqli_query($conn, $img_qry)) errlog(mysqli_error($conn), $img_qry);
            }
        }
    }

    respond(true, ['post_id' => $post_id, 'images_uploaded' => $uploadedImageLinks], 200, "Post created successfully");
}
if ($action === 'view_all_posts') {

    $site_id = $this_site_id;

    // Fetch all posts for this site
    $qry = "SELECT pc.id, pc.vendor_id, v.name as vendor_name, pc.content_type, pc.visibility, pc.status, pc.label, pc.tags, pc.location, pc.created_date
            FROM post_content pc
            LEFT JOIN vendor v ON pc.vendor_id = v.id
            WHERE pc.site_id = '" . mysqli_real_escape_string($conn, $site_id) . "'
            ORDER BY pc.created_date DESC";

    $res = mysqli_query($conn, $qry);

    if (!$res) {
        respond(false, [], 500, "Failed to fetch posts");
    }

    $posts = mysqli_fetch_all($res, MYSQLI_ASSOC);

    // Attach images for each post
    foreach ($posts as &$post) {
        $post_id = $post['id'];
        $img_qry = "SELECT image_url
                    FROM product_images
                    WHERE product_id = '" . intval($post_id) . "'
                      AND type = 'POSTS.'
                    ORDER BY id ASC";
        $img_res = mysqli_query($conn, $img_qry);
        $images = [];
        if ($img_res) {
            while ($img_row = mysqli_fetch_assoc($img_res)) {
                $images[] = $img_row['image_url'];
            }
        }
        $post['images'] = $images;
    }

    respond(true, $posts, 200, "All posts fetched successfully");
}
?>