part of 'equations.dart'; // This library is part of equations

// Other libraries need to be imported in root library
// Extensions libraries can access private fields from root library
int calculateMore() {
  return Math.max(_calculateSecret(), 1);
}
