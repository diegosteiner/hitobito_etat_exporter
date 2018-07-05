class CleanVisitor
  def visit(row)
    row['Adresse'] = row['Adresse']&.strip
    row
  end
end
