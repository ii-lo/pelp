/// <reference path="../../../tsd/tsd.d.ts" />

//= require knockout
//= require knockout.mapping

//------------------------------------------------------------------------------

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

    constructor(title: string, body: string, sender: User, receiver: User, sentDate?: Date) {
        this.title = title;
        this.body = body;
        this.sender = sender;
        this.receiver = receiver;
        this.sentDate = sentDate || new Date();
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

//------------------------------------------------------------------------------

class MessagesViewModel {
    messages: KnockoutObservableArray<Message> = ko.observableArray<Message>();

    initInbox(msgs: ServerMessage[]) {
        this.messages.removeAll();
        msgs.forEach((msg) => {
            this.messages.push(Message.fromServerMessage(msg));
        });
    }
}

//------------------------------------------------------------------------------

var viewModel = new MessagesViewModel();
ko.applyBindings(viewModel);

//------------------------------------------------------------------------------

$('#refresh-btn').on('click', function(e) {
    e.preventDefault();
    var btn = $(this).button('loading');

    setTimeout(function() {
        btn.button('reset');
    }, 5000);
});

$('#send-msg-btn').on('click', function() {
    var btn = $(this).button('loading');

    setTimeout(function() {
        btn.button('reset');
        $('#compose-modal').modal('hide');
    }, 5000);
});
