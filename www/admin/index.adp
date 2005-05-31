<master>
<property name="title">@title@</property>

<if @expenses:rowcount@ ne 0>
	<listtemplate name="expenses"></listtemplate>
</if>
<else>
	<p><a href="addedit-expense">Add Expense</a>
	<p> No expenses for this class.
</else>

