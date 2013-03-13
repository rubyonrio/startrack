# Startrack Tracker: [![Build Status][bimg]][blink] [![Code Climate]][codeclimatelink]

## What is it?

This is a SaaS project that intend to help agile teams through the a KanBan-like dashboard to manage projects, tasks and teams.

## License

This code is free to be used under the terms of the [GNU General Public License](https://github.com/rubyonrio/startrack/blob/master/COPYING).

## Bugs, Issues, Kudos and Catcalls

Comments are welcome. Send your feedback through the [issue tracker on GitHub][i]

## Contributors

We have a list of contributors. Check them all at:
[Contributors][c]

## Suggested features:

* Organization account
* Team members CRUD
* Project CRUD
  * Show project status
* User story CRUD
  * User Story has a total of tasks points
  * Show Finished Stories
  * Group Stories
  * Attach files to Stories
  * A Story may be accepted or not
  * Add Acceptance testing to a Story
* Task CRUD
  * User Story has many tasks
  * Each Task has status (done, new, assigned, etc)
  * Each Task has type (feature, bug, etc)
  * Each Task may has a owner
* Define Product Backlog
* Define Sprint Backlog
* Define workflow
* Priorize user stories
* Team velocity
* Show burndown chart

## To discuss

1. Organizations will have a limit of projects
2. Projects will have a max number of users
3. Change Story priority after starts the sprint
4. Define de DOD (Do Of Done) for a project
5. Pair programing for teams
6. Team alert for new entries on a User Story
7. Use github API to use github issues as Startrack task syncing

[i]:  http://github.com/rubyonrio/startrack/issues
[c]:  https://github.com/rubyonrio/startrack/contributors
[bimg]:  https://secure.travis-ci.org/rubyonrio/startrack.png
[blink]: http://travis-ci.org/rubyonrio/startrack
[codeclimatelink]: https://codeclimate.com/github/rubyonrio/startrack
