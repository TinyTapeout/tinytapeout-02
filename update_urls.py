#!/usr/bin/env python3
import stripe, os
stripe.api_key = os.environ['STRIPE_TOKEN']
checkouts = stripe.checkout.Session.list(limit=400)

with open("project_urls_init.py") as fh:
    urls_header = fh.read()

git_urls = []
for checkout in checkouts:
    if checkout['payment_status'] == 'paid':
        if 'github' in checkout['metadata']:
            #print(checkout['metadata']['github'], checkout['customer_details']['email'])
            git_urls.append(checkout['metadata']['github'])

git_urls.reverse()
with open("project_urls.py", 'w') as fh:
    fh.write(urls_header)

    for git_url in git_urls:
        fh.write(f'    "{git_url}",\n')

    fh.write("    ]\n")

print(f"created project_urls.py with {len(git_urls)} projects")
