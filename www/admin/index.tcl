ad_page_contract {

    List line expenses for a given class
    
    @author Hamilton Chua (hamilton.chua@gmail.com)
    @creation-date 2005-05-14
    @cvs-id $Id$

} {
	orderby:optional
}

set title "Expenses"
set context $title
set package_id [ad_conn package_id]

# use list template to create list of expenses

template::list::create \
    -name expenses \
    -multirow expenses \
    -key exp_id \
    -actions {
            "Add Expense" "addedit-expense" "Add An Expense"
    } -bulk_actions { 
	    "Delete" "delete-expense" "Delete Expenses"
    } -elements {
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
	exp_exported {
		label "Exported"
		display_template { 
			<if @expenses.exp_exported@ eq "t">
				Yes
			</if>
			<else>
				No
			</else>
		}
	}
	action {
		label "Action"
		display_template { <a href="addedit-expense?exp_id=@expenses.exp_id@">Edit</a> | <a href="delete-expense?exp_id=@expenses.exp_id@">Delete</a>}
	}
    } -orderby {
	exp_date { orderby exp_date }
	exp_amount { orderby exp_amount }
    } -no_data { No expenses for this class. }

# build the multirow

set orderby_clause "[template::list::orderby_clause -name expenses -orderby]"

db_multirow expenses get_expenses { }
