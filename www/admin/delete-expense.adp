<master>
<property name="title">@title@</property>

@confirm_message;noquote@
<p><listtemplate name="expense_items"></listtemplate></p>

  <form method=post action="delete-expense-2">
    @hidden_vars;noquote@
    <blockquote><input type=submit value="Yes">&nbsp;<input type=button onclick="history.back()" value="No"></blockquote>
  </form>

