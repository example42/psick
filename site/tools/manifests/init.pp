# Bogus tools class. Included to allow usage of namespace for functions
#
class tools (
  Boolean $bogus = true,
) {

  if ! $bogus {
    notify { 'Not Bogus': }
  }
}
