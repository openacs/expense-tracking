ad_page_contract {
	Delete expenses

	@author Hamilton Chua (hamilton.chua@gmail.com)
	@creation-date 2005-05-14
	@cvs-id $Id$
} {
	exp_id:multiple,notnull
	{return_url ""}
} -errors {
	exp_id:notnull "You must provide the expenses to be deleted."
}

set title "Delete Expenses"
set confirm_message "Are you sure you want to delete the following expense items?"

# generate list of exp_item_id's for deletion
for {set i 0} {$i < [llength $exp_id]} {incr i} {
    set id_$i [lindex $exp_id $i]
    lappend bind_id_list ":id_$i"
}

template::list::create \
     -name expense_items \
     -multirow expense_items\
     -elements {
        exp_expense {
        	label "Expense"
	}
	exp_amount {
		label "Amoumt"
		display_template { $@expense_items.exp_amount@ }
	}
      }	    

set items_for_delete [join $bind_id_list ","]
db_multirow expense_items item_del_query "select exp_expense, exp_date, exp_amount from expenses where exp_id in ($items_for_delete)"

set hidden_vars [export_form_vars exp_id return_url]
