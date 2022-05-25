<div class="ty-mainbox-body">
    <div id="product_features_{$block.block_id}">
        <div class="ty-feature">
            {if $department_data.main_pair}
            <div class="ty-feature__image">
                {include file="common/image.tpl" images=$department_data.main_pair}
            </div>
            {/if}
            <div class="ty-feature__description ty-wysiwyg-content">
                {$department_data.description nofilter}
            </div>
        </div>
    </div>
</div>

<div class="ty-mainbox-body">
    <div class="row-fluid">
        <bdi>
            <a>{$department_data.employee_id|fn_get_user_name}</a>
        </bdi>
    </div>
</div>

{capture name="mainbox_title"}{$department_data.variant nofilter}{/capture}
