my-libguides-librarians
=========================

Get an RSS feed of librarians who are responsible for given subjects, and link to their LibGuides profiles.

This is a temporary solution to a problem described at
[Is it possible to search librarian profiles in LibGuides and embed matches on other pages?](http://libraries.stackexchange.com/questions/650/is-it-possible-to-search-librarian-profiles-in-libguides-and-embed-matches-on-ot)

I asked:

> My LibGuides profile has some information about me and I would like to be able to show it on other web pages outside LibGuides, such as in Moodle or a student portal. That's possible using the LibGuides API if I want to specify my profile directly by saying "insert wdenton's profile here." But what I would like to do is search all of my library's profiles for "s:SC/MATH", find the one that matches (mine), and embed the box elsewhere.

> s:SC/MATH is the code we use to say that a librarian has subject responsibilities for the science faculty's mathematics program. We use these tags in various places to associate guides with eresources and librarians, but there's no programmatic way that I can see to say somewhere "this resource is tagged with subject X and here is the contact information for the librarian who handles that subject, found by automatically pulling it in from LibGuides through a search for X."

Sean Hannan replied:

> No, it's not currently possible. The LibGuides API does not allow you to filter responses by any kind of string for any call. In order to get a profile from LibGuides, you need to feed it a user ID (an internal number).

> If you were ambitious, you could create a middleware app to handle it. Use the API to get a list of all of those users. Scrape the profile contents from all of those users and index it in a datastore of some sort. Create your own API on top of that index that will give you a list of user IDs based on a search string. Feed those user IDs back into the LibGuides API to get the profiles.

> That is a slow and incredibly roundabout way of getting what you are after. You might have more luck asking Springshare for this feature as they are quite responsive when it comes to feature requests (in my experience).

I submitted the request to LibGuides (on Twitter!) and they put it into their request system. Until it's ready, this could work.

# Usage

Edit your LibGuides instituional ID in `make-libguides-map`.

Run this as cronjob somewhere: 

    /path/to/my-libguides-librarians/make-libguides-map > /var/www/html/librarian-mapping.txt

(If you put the file somwhere else, edit `find-my-librarian` to look there.)

Then run `find-my-librarian` as a CGI, and when you call it, pass in `programs=ap/psyc` or some such code.  If there are two or more, separate them by commas: `programs=sc/math,fa/danc`

It will return an RSS feed of librarians responsible for those subjects. It falls back to reference desks at branches if no individual librarians can be found.

## Adding the Subject tags field to librarian profiles

This service requires that you add the "Subject tags" custom field to the librarian profiles.

1. Log in to your LibGuides account as an administrator.
1. Go to Admin Stuff > Accounts
1. Choose the Profile Options tab
1. Create a `Subject tags` field

How to edit your subject tags:

1. Log in to LibGuides.
1. Go to the Dashboard.
1. Choose "edit" in the top right-hand corner of your profile box.
1. Look in "Additional Fields" and you'll see the "Subject tags" box

## Note

This is very specific to [York University Libraries](http://www.library.yorku.ca/) right now.

