
# where are we
set current_url [ad_conn url]?[ad_conn query]

if {![info exists package_id]} {
    set package_id [ad_conn package_id]
}

if {![info exists community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

# where id dotlrn-ecommerce mounted
set expense_tracking_url [dotlrn_community::get_community_url $community_id]

template::list::create \
    -name expenses \
    -multirow expenses \
    -pass_properties { expense_tracking_url current_url} \
    -key exp_id \
    -elements {
	exp_date {
		label "Date"
	}
	exp_expense {
		label "Expense"
	}
	exp_amount {
		label "Amount"
		aggregate "sum"
		aggregate_label "Total :  $"
		display_template { $ @expenses.exp_amount;noquote@ }
	}
	action {
		label "Action"
		display_template { <a href="@expense_tracking_url@/expense-tracking/admin/addedit-expense?exp_id=@expenses.exp_id@&return_url=@current_url@">Edit</a> | <a href="@expense_tracking_url@/expense-tracking/admin/delete-expense?exp_id=@expenses.exp_id@&return_url=@current_url@">Delete</a>}
	}
    } -orderby {
	exp_date { orderby exp_date }
	exp_amount { orderby exp_amount }
    } -no_data { No expenses for this class. }

# build the multirow

set orderby_clause "[template::list::orderby_clause -name expenses -orderby]"

db_multirow expenses get_expenses { }
