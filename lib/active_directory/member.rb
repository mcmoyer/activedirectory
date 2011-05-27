#-- license
#
#  Based on original code by Justin Mecham and James Hunt
#  at http://rubyforge.org/projects/activedirectory
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#++ license

module ActiveDirectory
  module Member
    #
    # Returns true if this member (User or Group) is a member of
    # the passed Group object.
    #
    def member_of?(usergroup)
      begin
        groups = memberOf
      rescue ArgumentError
        #if we catch an error from the memberOf call, it probably means there are no groups
        return false
      end
      return false if groups.nil? || groups.empty?
      group_dns = [groups].flatten.collect {|g| g.dn }
      group_dns.include?(usergroup.dn)
    end

    #
    # Add the member to the passed Group object. Returns true if this object
    # is already a member of the Group, or if the operation to add it succeeded.
    #
    def join(group)
      return false unless group.is_a?(Group)
      group.add(self)
    end

    #
    # Remove the member from the passed Group object. Returns true if this
    # object is not a member of the Group, or if the operation to remove it
    # succeeded.
    #
    def unjoin(group)
      return false unless group.is_a?(Group)
      group.remove(self)
    end
  end
end
