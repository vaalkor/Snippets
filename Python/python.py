# An equivalent of javascript find, Linq FirstOrDefault.
nextVal = next((x for x in data if someConditionOnX(x)), None)

foundValue = mylist[mylist.index('val')] if 'val' in mylist else None

# get utc timestamp
# be aware the datetime.utcnow() does not return a timezone aware date. 
int(datetime.utcnow().timestamp())

#convert unix time to datetime
datetime.utcfromtimestamp(ts)

# print datetime
date_object.strftime('%Y-%m-%d %H:%M:%S'))
date_object.strftime('%A %d %Y %H:%M:%S'))

# print numbers with commas = '1,000,000'
"{:,}".format(10000000)

# These 5 functions calls all produce the same result
def concat_iterable(iterable):
    return ''.join((str(x) for x in iterable))

def concat_vals(*values):
    return ''.join((str(x) for x in values))

print(concat_iterable([1,2,3,4,5]))
print(concat_iterable((1,2,3,4,5)))
print(concat_vals(*[1,2,3,4,5]))
print(concat_vals(*(1,2,3,4,5)))
print(concat_vals(1,2,3,4,5))