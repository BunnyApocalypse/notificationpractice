/*
* Copyright (c) 2011-2018 Your Organization (https://yourwebsite.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Author <bunnyapocalypse@protonmail.com>
*/
public class MyApp : Gtk.Application {

    public MyApp () {
        Object (
            application_id: "com.github.bunnyapocalypse.notificationpractice",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 500;
        main_window.default_width = 300;
        main_window.title = _("Notify");
        
        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 6;
        
        var title_label = new Gtk.Label (_("Notifications"));
        var show_button = new Gtk.Button.with_label (_("Show"));
        
        var replace_button = new Gtk.Button.with_label (_("Replace"));
        
        var entry = Unity.LauncherEntry.get_for_desktop_id ("com.github.bunnyapocalypse.notificationpractice.desktop");
        entry.count_visible = true;
        entry.count = 9;
        entry.progress_visible = true;
        entry.progress = 0.49f;
        
        grid.add (title_label);
        grid.add (show_button);
        grid.add (replace_button);
        
        main_window.add (grid);
        main_window.show_all ();
     
        show_button.clicked.connect (() => {
            var notification = new Notification (_("Ouch, you clicked me!"));
            notification.set_body (_("That really hurt!"));
            var icon = new GLib.ThemedIcon ("media-tape");
            notification.set_icon (icon);
            notification.set_priority (NotificationPriority.URGENT);
            
            this.send_notification ("com.github.bunnyapocalypse.applicationpractice", notification);
        });
        
        replace_button.clicked.connect (() => {
            var notification = new Notification (_("Replacement"));
            notification.set_body (_("Let's get rid of that complainer"));
            
            var icon = new GLib.ThemedIcon ("audio-volume-muted");
            notification.set_icon (icon);
            
            this.send_notification ("com.github.bunnyapocalypse.applicationpractice", notification);
        });
    }
    

    

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }

}
