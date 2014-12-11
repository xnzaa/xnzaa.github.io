---
layout: post
title:  "Monitor the Changes in EditText"
date:    2013-11-12 21:45
categories: android
---

#### There is no **"setOnXXXXXXXListener"** Method in Android for EditText. If we want to monitor the changes in EditText, how can we achieve that ?



In fact, it's simple because of the Method --- addTextChangedListner(TextWatcher watcher)

In [TextView\|Android Developers](http://developer.android.com/reference/android/widget/TextView.html), we can find a Method called addTextChangedListener(TextWatcher watcher).:


{% highlight java %}


public void addTextChangedListener (TextWatcher watcher)
{% endhighlight %}

Added in [API level 1](http://developer.android.com/guide/topics/manifest/uses-sdk-element.html#ApiLevels)

Adds a TextWatcher to the list of those whose methods are called whenever this TextView's text changes.

#### About TextWatcher, it has three Public Method:

{% highlight java %}
abstract void afterTextChanged(Editable s)
{% endhighlight %}
This method is called to notify you that, somewhere within s, the text has been changed.

{% highlight java %}
abstract void beforeTextChanged(CharSequence s, int start, int count, int after)
{% endhighlight %}
This method is called to notify you that, within s, the count characters beginning at start are about to be replaced by new text with lengthafter.

{% highlight java %}
abstract void onTextChanged(CharSequence s, int start, int before, int count)
{% endhighlight %}
This method is called to notify you that, within s, the count characters beginning at start have just replaced old text that had lengthbefore.





#### So you can use it to monitor your changes in EditText just like this:

{% highlight java %}
editText.addTextChangedListener(new TextWatcher() {


   @Override
   public void beforeTextChanged(CharSequence s, int start, int count,
     int after) {
    // TODO Auto-generated method stub

   }


   @Override
   public void onTextChanged(CharSequence s, int start, int before, int count) {
    // TODO Auto-generated method stub

   }


   @Override
   public void afterTextChanged(Editable s) {
    // TODO Auto-generated method stub

   }
  });
{% endhighlight %}



Reference:[Android Developers](http://developer.android.com/)
