<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.3</version></rdbms>

    <fullquery name="exptrack::delete_expense.delete_q">
        <querytext>
	        select expenses__delete (
			:exp_id
        	)
        </querytext>
    </fullquery>

    <fullquery name="exptrack::add_expense.add_q">
        <querytext>
	        select expenses__new (
			:id,
			:expense,
			:date,
			:amount,
			:class_key,
			:community_id,
			:user_id,
			:package_id,
			:creation_ip
        	)
        </querytext>
    </fullquery>

    <fullquery name="exptrack::update_expense.update_q">
        <querytext>
	        select expenses__update (
			:id,
			:expense,
			:date,
			:amount,
			:class_key,
			:community_id,
			:user_id
        	)
        </querytext>
    </fullquery>

</queryset>
