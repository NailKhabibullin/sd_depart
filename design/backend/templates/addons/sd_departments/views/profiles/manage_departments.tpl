{** departments section **}

{capture name="mainbox"}
    <form action="{""|fn_url}" method="post" id="departments_form" name="departments_form" enctype="multipart/form-data">
        <input type="hidden" name="fake" value="1" />
        {include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id="pagination_contents_departments"}
            {$c_url=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
            {$rev=$smarty.request.content_id|default:"pagination_contents_departments"}
            {include_ext file="common/icon.tpl" class="icon-`$search.sort_order_rev`" assign=c_icon}
            {include_ext file="common/icon.tpl" class="icon-dummy" assign=c_dummy}
            {$department_statuses=""|fn_get_default_statuses:true}
            {$has_permission = fn_check_permissions("departments", "update_status", "admin", "POST")}

            {if $departments}
                {capture name="departments_table"}
                    <div class="table-responsive-wrapper longtap-selection">
                        <table class="table table-middle table--relative table-responsive">
                            <thead
                                data-ca-bulkedit-default-object="true"
                                data-ca-bulkedit-component="defaultObject"
                                <tr>
                                    <th width="15%"><a class="cm-ajax" data-ca-target-id={$rev}>{("Logo")}</a></th>
                                    <th><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("name")}{if $search.sort_by === "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                                    <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=timestamp&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("creation_date")}{if $search.sort_by === "timestamp"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                                    <th width="6%" class="mobile-hide">&nbsp;</th>
                                    <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by === "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                                    <th width="6%" class="left mobile-hide">
                                        {include file="common/check_items.tpl" is_check_disabled=!$has_permission check_statuses=($has_permission) ? $department_statuses : '' }
                                        <input type="checkbox"
                                            class="bulkedit-toggler hide"
                                            data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
                                            data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                                        />
                                    </th>
                                </tr>
                            </thead>
                            {foreach from=$departments item=department}
                            <tr class="cm-row-status-{$department.status|lower} cm-longtap-target">
                                {$allow_save=true}
                                {if $allow_save}
                                    {assign var="no_hide_input" value="cm-no-hide-input"}
                                {else}
                                    {assign var="no_hide_input" value=""}
                                {/if}
                                <td class="departments-list__image">
                                    {include
                                        file="common/image.tpl"
                                        image=$department.main_pair.icon|default:$department.main_pair.detailed
                                        image_id=$department.main_pair.image_id
                                        image_width="50"
                                        image_height="50"
                                        href="profiles.update_department?department_id=`$department.department_id`"|fn_url
                                    }
                                </td>
                                <td class="{$no_hide_input}" data-th="{__("name")}">
                                    <a class="row-status" href="{"profiles.update_department?department_id=`$department.department_id`"|fn_url}">{$department.department}</a>
                                </td>
                                <td width="15%" data-th="{__("creation_date")}">
                                    {$department.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}
                                </td>
                                <td width="6%" class="mobile-hide">
                                    {capture name="tools_list"}
                                            <li>{btn type="list" text=__("edit") href="profiles.update_department?department_id=`$department.department_id`"}</li>
                                        {if $allow_save}
                                            <li>{btn type="list" class="cm-confirm" text=__("delete") href="profiles.delete_department?department_id=`$department.department_id`" method="POST"}</li>
                                        {/if}
                                    {/capture}
                                    <div class="hidden-tools">
                                        {dropdown content=$smarty.capture.tools_list}
                                    </div>
                                </td>
                                <td width="10%" class="right" data-th="{__("status")}">
                                    {include file="common/select_popup.tpl" id=$department.department_id status=$department.status hidden=true object_id_name="department_id" table="departments" popup_additional_class="`$no_hide_input` dropleft"}
                                </td>
                                <td width="6%" class="left mobile-hide">
                                    <input type="checkbox" name="departments_ids[]" value="{$department.department_id}" class="cm-item {$no_hide_input} cm-item-status-{$department.status|lower}" />
                                </td>
                            </tr>
                            {/foreach}
                        </table>
                    </div>
                {/capture}

                {include file="common/context_menu_wrapper.tpl"
                    form="departments_form"
                    object="departments"
                    items=$smarty.capture.departments_table
                    has_permissions=$has_permission
                }
            {else}
                <p class="no-items">{__("no_data")}</p>
            {/if}

            {include file="common/pagination.tpl" div_id="pagination_contents_departments"}
        </div>
    </div>
        {capture name="buttons"}
            {capture name="tools_list"}
                {if $departments}
                    <li>{btn type="delete_selected" dispatch="dispatch[departments.delete_departments]" form="departments_form"}</li>
                {/if}
            {/capture}
            {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
        {/capture}
        {capture name="adv_buttons"}
            {if $departments}
                {include file="buttons/save.tpl"
                    but_name="dispatch[profiles.update_departments]"
                    but_role="submit-link"
                    but_target_form="departments_m_update_form"}
            {/if}
            {include file="common/tools.tpl"
                tool_href="profiles.add_department"
                prefix="top"
                hide_tools="true"
                title="Добавить отдел"
                icon="icon-plus"}
        {/capture}

    </form>


        <div class="sidebar cm-sidebar " id="elm_sidebar" style="top: 43px;">
            <div class="sidebar-wrapper">
                <div class="sidebar-row">
                    <h6>Search</h6>
                    <form action="{""|fn_url}" name="search_form" method="get" class="cm-disable-empty cm-processed-form" id="search_form"><input type="password" class="hidden" autocomplete="new-password"> <!-- turn off Chrome autocomplete -->
                    <input type="hidden" name="type" value="simple" autofocus="autofocus">
                    <input type="hidden" name="pcode_from_q" value="Y">
                        <div id="simple_search_common">
                            <div id="simple_search">
                                <div class="sidebar-field">
                                    <label>Find department</label>
                                    <input type="text" name="q" size="20" value="">
                                </div>
                            </div>
                        </div>
                        <div class="sidebar-field advanced-search-field">
                            <input class="btn advanced-search-field__search" type="submit" name="dispatch[departments.manage_departments]" value="Search">
                        </div>
                </div>
            </div>
        </div>

{/capture}

{hook name="departments:manage_mainbox_params"}
    {$page_title = __('sd_departments.departments')}
    {$select_languages = true}
{/hook}

{include
    file="common/mainbox.tpl"
    title=$page_title
    content=$smarty.capture.mainbox
    adv_buttons=$smarty.capture.adv_buttons
    select_languages=$select_languages
    sidebar=$smarty.capture.sidebar
}

{** ad section **}
