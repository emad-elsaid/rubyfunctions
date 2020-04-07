# We use it to stop the execution of actions in case the user is not permitted
# to do the action
class UnauthorizedException < StandardError
end
