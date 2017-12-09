lines = [line.rstrip('\n').split('\t') for line in open('item_names_new','r+')]
for q in lines:
    print q
    