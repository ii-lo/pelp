/// <reference path="../../../tsd/tsd.d.ts" />

//= require knockout
//= require knockout.mapping

/*
 * Models
 */

interface User {
    id: number;
    name: string;
}

class Message {
    id: number;
    parentId: number;

    title: string;
    body: string;
    sentDate: Date;

    receivers: User[];
    sender: User;

    read = ko.observable(false);
    flagged = ko.observable(false);
    inTrash = ko.observable(false);

    constructor(id: number, parentId: number, title: string, body: string, receivers: User[], sender: User, sentDate: Date = new Date()) {
        this.id = id;
        this.parentId = parentId;
        this.title = title;
        this.body = body;
        this.sender = sender;
        this.receivers = receivers;
        this.sentDate = sentDate;
    }

    isReceived(user: User): boolean {
        return this.receivers.some((u) => u.id == user.id);
    }

    isSent(user: User): boolean {
        return this.sender.id == user.id;
    }
}

/*
 * View data
 */

declare var VIEW_DATA: ViewData;

interface ViewData extends Array<any> {}
interface ViewDataUser extends Array<any> {}
interface ViewDataMessage extends Array<any> {}

module ViewDataUtil {
    export function readUser(data: ViewDataUser): User {
        return { id: data[0], name: data[1] }
    }

    export function readMessage(data: ViewDataMessage): Message {
        var msg = new Message(data[0], data[1], data[2], data[3], data[7].map(readUser), readUser(data[8]), data[6]);
        msg.flagged(data[4]);
        msg.inTrash(data[5]);
        return msg;
    }
}

/*
 * ViewModels
 */

class MessagesViewModel {
    messages = ko.observableArray<Message>();
    currentUser: User;

    receivedMessages = ko.pureComputed(() => this.messages().filter((msg) => msg.isReceived(this.currentUser) && !msg.inTrash()));
    flaggedMessages  = ko.pureComputed(() => this.messages().filter((msg) => msg.flagged() && !msg.inTrash()));
    sentMessages     = ko.pureComputed(() => this.messages().filter((msg) => msg.isSent(this.currentUser) && !msg.inTrash()));
    allMessages      = ko.pureComputed(() => this.messages().filter((msg) => !msg.inTrash()));
    trashMessages    = ko.pureComputed(() => this.messages().filter((msg) => msg.inTrash()));

    constructor(viewData?: ViewData) {
        this.currentUser = ViewDataUtil.readUser(viewData[0]);
        viewData[1].forEach((msg: ViewDataMessage) => {
            this.messages.push(ViewDataUtil.readMessage(msg));
        });
    }
}

ko.applyBindings(new MessagesViewModel(VIEW_DATA));

/*
 * DOM Manipulations
 */

$('#refresh-btn').on('click', function(e) {
    e.preventDefault();
    var btn = $(this).button('loading');

    setTimeout(function() {
        btn.button('reset');
    }, 5000);
});

$('#send-msg-btn').on('click', function() {
    var sendBtn = $(this).button('loading');
    var cancelBtn = $('#cancel-msg-btn').prop('disabled', true);

    setTimeout(function() {
        sendBtn.button('reset');
        cancelBtn.prop('disabled', false);
        $('#compose-modal').modal('hide');
    }, 5000);
});
