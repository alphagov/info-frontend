# ADR: Retiring Info Frontend 

Date: 2023-02-20

## Status

Agreed.

## Context 

Info pages display [Maslow][1] information (the needs for the page) and
historically, performance information such as how many visitors a page has had.

Adding /info to the start of any GOV.UK URL such as
https://www.gov.uk/info/employers-sick-pay will return the info page for the
content. 

Most of the pages Info Frontend renders are void of content as user needs are
rarely used. To put this in perspective, there are currently 413 user needs,
applied to 1164 published pages on www.gov.uk. As there is an /info page for
every page on www.gov.uk, this is a very small proportion. ~73% of the
published pages have not been created, or publicly updated since 2018 and the
last change to a published user need in Maslow was in June 2018.

Previously, info pages also contained performance data however this has been
turned off as the [Performance Platform has been decommissioned][2] so there are no
metrics to display.

We also don't index or link to any of these pages and so there will be little
organic traffic to them. CIOP have gathered some analytics and confirmed that:

* nearly all pages receive very little traffic, if any 
* compared to the visits for the parent page, the traffic looks even smaller 
* most of the traffic seems to come from, say, references in blogs

[1]: https://github.com/alphagov/maslow
[2]: https://docs.publishing.service.gov.uk/repos/performanceplatform-admin.html

## Decision

As we no longer provide performance data on the /info pages or maintain the
user needs information, we are proposing to remove the pages and thus, retire
Info Frontend.

We plan to unpublish the pages with a 410 gone [3]. We'll remove the existing
prefix info/ route that points to info-frontend and instead return gov.uk's
static 410 page instead [4]. We did consider creating a single retirement
content page for and redirecting all the /info page requests to it, however
this was deemed unnecessary as we've already communicated the upcoming
retirement to departments and /info pages receive such little traffic that it
didn't seem worthwhile.

As part of this work, we won't be retiring Maslow or the backing data, we'll
just be removing the frontend that supports /info pages. Publishers will still
be able to tag user needs in the various publishing apps. The Publishing team
have previously informed users of their intention to retire Maslow, but this
work is not currently scheduled.

We will inform the relevant teams internally and post this to the wider content
community (x-gov) to raise awareness of the upcoming change.

[3]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/410
[4]: https://github.com/alphagov/static/blob/main/app/views/root/410.html.erb

## Consequences

Removing /info pages reduces reputational damage, as the:

* vast majority of pages look broken to anyone who sees them
* backing data (user needs) is not actively maintained and thus could be incorrect
* performance data is missing
* /info pages are not accessible

Reduces gov.uk maintenance burden as one less app to maintain (monitoring,
dependabot, Rails upgrades etc).

Paves the way for removing, or repurposing [Maslow][1]. If we decide we still
want to display user needs for certain pages, then a solution should be
proposed that is maintainable and useful.

Risk of users complaining about user needs disappearing on info pages they
visit (albeit small risk given these pages are pretty much hidden and analytics
confirm really low traffic).  

Risk of the proposed single content page becoming stale, e.g if we point users
to the content API but then the backing data is removed without consideration
of the new page.
