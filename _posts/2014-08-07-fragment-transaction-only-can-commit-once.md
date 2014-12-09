---
layout: post
title:  "About FragmentTransaction"
date:    2014-08-07 20:53
categories: android
---
In my mind, a better **FragmentTransaction** should like **git**, it gives you a buffer area and you can commit for multiple times.

BUT! The truth is that one **FT** only can commit once. TAT

Here are some packaged func for add/replace fragment without add it to backstack.

{% highlight java %}
//Not-add-to-backstack Add
    private void addFragment(int containerID, Fragment fragment){

        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.add(containerID, fragment);
        fragmentTransaction.commit();

    }

    //Not-add-to-backstack Replace
    private void replaceFragment(int containerID, Fragment fragment){

        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.replace(containerID, fragment);
        fragmentTransaction.commit();
    }
{% endhighlight %}

If you want to add them to backstack you can easily add this before commit():

{% highlight java %}
fragmentTransaction.addToBackStack(null);
{% endhighlight %}
