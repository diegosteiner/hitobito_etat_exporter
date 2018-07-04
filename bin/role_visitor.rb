class RoleVisitor
  ROLES = [
    'Abteilungsleiter',
    'Stufenleiter',
    'Einheitsleiter',
    'Mitleiter',
    'Coach',
    'Kassier',
    'Präses'
].freeze
  MatchingRole = Struct.new(:role, :role_type, :role_pos)

  def visit(row)
    roles = matching_roles(row['Rollen'])
    return unless roles.any?
    roles.map do |role|
      row.to_h.dup.tap do |r|
        r['Rollen'] = role.role
        r['RolePos'] = role.role_pos
      end
    end
  end

  private

  def matching_roles(roles)
    return [] unless roles.respond_to?(:split)
    roles.split(', ').map do |role|
      ROLES.each_with_index.map do |r, i|
        next unless role.start_with?(r)
        MatchingRole.new(role, r, i)
      end
    end.flatten.compact
  end
end
