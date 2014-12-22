/// <reference path="../../../tsd/tsd.d.ts" />

//= require marked
//= require bootstrap-markdown
//= require bootstrap-markdown.pl.js

interface JQuery {
    markdown:(options?:any)=>JQuery;
}
