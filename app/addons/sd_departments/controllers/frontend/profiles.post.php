<?php

use Tygh\Registry;
use Tygh\BlockManager\ProductTabs;

use function Tygh\fn_print_r;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'departments') {

    Tygh::$app['session']['continue_url'] = "products.departments";

    $params = $_REQUEST;

    $params['user_id'] = Tygh::$app['session']['auth']['user_id'];

    list($departments, $search) = fn_get_departments($params, Registry::get('settings.Appearance.products_per_page'), CART_LANGUAGE);

    Tygh::$app['view']->assign('departments', $departments);
    Tygh::$app['view']->assign('search', $search);
    Tygh::$app['view']->assign('columns', 3);

    fn_add_breadcrumb("Отделы");

} elseif ($mode == 'department') {
    //fn_print_die('test');
    $department_data = [];
    $department_id = !empty($_REQUEST['department_id']) ? $_REQUEST['department_id'] : 0;
    $department_data = fn_get_department_data($department_id, CART_LANGUAGE);

    if (empty($department_data)) {
        return [CONTROLLER_STATUS_NO_PAGE];
    }

    Tygh::$app['view']->assign('department_data', $department_data);
    fn_add_breadcrumb(["Отделы", $department_data['department']]);

    $employee_id = !empty($department_data['employee_id']) ? fn_get_user_name($department_data['employee_id']) : [];
}