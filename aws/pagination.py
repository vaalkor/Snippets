for page in sm.get_paginator('list_secrets').paginate(PaginationConfig={'PageSize': 100}):
    for secret in page['SecretList']:
        #Perform terrible deeds here.