hash = { a: 'ant', b: 'bear' }
hash.shift

p hash

# #shift will remove the first element from the hash. Element order will be based on entry order (since one of the more recent versions of Ruby). In this case, [:a, 'ant'] will be removed and the hash will become {:b=>'bear'}.