/// <reference path="../../../tsd/tsd.d.ts" />

//= require knockout
//= require knockout.mapping

// Models ----------------------------------------------------------------------

interface User {
    id: number;
    name: string;
    email: string;
}

class Message {
    title: string;
    body: string;
    sentDate: Date;

    sender: User;
    receiver: User;

    read: boolean = false;
    flagged: boolean = false;
    inTrash: boolean = false;

    constructor(title: string, body: string, sender: User, receiver: User, sentDate: Date = new Date()) {
        this.title = title;
        this.body = body;
        this.sender = sender;
        this.receiver = receiver;
        this.sentDate = sentDate;
    }

    isReceived(user: User): boolean {
        return this.receiver.id == user.id;
    }

    isSent(user: User): boolean {
        return this.sender.id == user.id;
    }

    static fromServerMessage(msg: ServerMessage): Message {
        return new Message(msg.title, msg.body, msg.sender, msg.receiver, new Date(msg.created_at));
    }
}

interface ServerMessage {
    title: string;
    body: string;
    created_at: string;

    sender: User;
    receiver: User;
}

// View data -------------------------------------------------------------------

declare var VIEW_DATA: ServerMessage[];

// ViewModels ------------------------------------------------------------------

class MessagesViewModel {
    messages = ko.observableArray<Message>();
    currentUser = { id: 1, name: "Marek Kaput", "email": "jjkbtv@gmail.com" }

    receivedMessages = ko.pureComputed(() => {
        return this.messages().filter((msg) => msg.isReceived(this.currentUser) && !msg.inTrash);
    });

    flaggedMessages = ko.pureComputed(() => {
        return this.messages().filter((msg) => msg.flagged && !msg.inTrash);
    });

    sentMessages = ko.pureComputed(() => {
        return this.messages().filter((msg) => msg.isSent(this.currentUser) && !msg.inTrash);
    });

    allMessages  = ko.pureComputed(() => {
        return this.messages().filter((msg) => !msg.inTrash);
    });

    trashMessages = ko.pureComputed(() => {
        return this.messages().filter((msg) => msg.inTrash);
    });

    constructor(viewData?: any) {
        this.loadMsgs(viewData);
    }

    loadMsgs(msgs: ServerMessage[] = []) {
        msgs.forEach((msg) => {
            this.messages.push(Message.fromServerMessage(msg));
        });
    }
}

ko.applyBindings(new MessagesViewModel(VIEW_DATA));

// DOM Manipulations -----------------------------------------------------------

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
