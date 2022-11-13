import stripe, os
stripe.api_key = os.environ['STRIPE_TOKEN']
checkouts = stripe.checkout.Session.list(limit=400)
git_urls = []
for checkout in checkouts:
    if checkout['payment_status'] == 'paid':
        if 'github' in checkout['metadata']:
            #print(checkout['metadata']['github'], checkout['customer_details']['email'])
            git_urls.append(checkout['metadata']['github'])

git_urls.reverse()
for git_url in git_urls:
    print(git_url)
