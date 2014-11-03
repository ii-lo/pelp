/// <reference path="../../../tsd/tsd.d.ts" />

//= require knockout
//= require knockout.mapping

declare var VIEW_DATA: any;

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

    isRead: boolean = false;
    isFlagged: boolean = false;
    isInTrash: boolean = false;

    constructor(title: string, body: string, sender: User, receiver: User, sentDate: Date = new Date()) {
        this.title = title;
        this.body = body;
        this.sender = sender;
        this.receiver = receiver;
        this.sentDate = sentDate;
    }

    isUserReceiver(user: User): boolean {
        return this.receiver.id == user.id;
    }

    isUserSender(user: User): boolean {
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

// ViewModels ------------------------------------------------------------------

class MessagesViewModel {
    messages: KnockoutObservableArray<Message> = ko.observableArray<Message>();

    constructor(viewData?: any) {
        this.loadMsgs(viewData);
    }

    loadMsgs(msgs: ServerMessage[] = []) {
        msgs.forEach((msg) => {
            this.messages.push(ko.mapping.fromJS(Message.fromServerMessage(msg)));
        });
    }
}

ko.applyBindings(new MessagesViewModel(VIEW_DATA));

// DOM Manipulations ------------------------------------------------------

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
