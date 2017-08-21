.class public LHelper;
.super Ljava/lang/Object;

.method public static toCharArrayx(Ljava/lang/String;)[C
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toCharArray()[C
    move-result-object v0
    return-object v0
.end method

.method public static lengthx(Ljava/lang/String;)I
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->length()I
    move-result v0
    return v0
.end method

.method public static printlnx(Ljava/io/PrintStream;Ljava/lang/String;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    return-void
.end method

.method public static addx(Ljava/util/ArrayList;Ljava/lang/Object;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    move-result v0
    return v0
.end method

.method public static putx(Ljava/util/HashMap;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method

.method public static toStringx(Ljava/lang/StringBuilder;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static appendx(Ljava/lang/StringBuilder;I)Ljava/lang/StringBuilder;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    return-object v0
.end method

.method public static notifyDataSetChangedx(Landroid/widget/SimpleAdapter;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/widget/SimpleAdapter;->notifyDataSetChanged()V
    return-void
.end method

.method public static setOnScrollListenerx(Landroid/widget/ListView;Landroid/widget/AbsListView$OnScrollListener;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V
    return-void
.end method

.method public static clearx(Ljava/util/ArrayList;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/util/ArrayList;->clear()V
    return-void
.end method

.method public static setTextx(Landroid/widget/TextView;Ljava/lang/CharSequence;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    return-void
.end method

.method public static closex(Landroid/database/Cursor;)V
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/database/Cursor;->close()V
    return-void
.end method

.method public static showx(Landroid/app/AlertDialog$Builder;)Landroid/app/AlertDialog;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    move-result-object v0
    return-object v0
.end method

.method public static setPositiveButtonx(Landroid/app/AlertDialog$Builder;Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    move-result-object v0
    return-object v0
.end method

.method public static setTitlex(Landroid/app/AlertDialog$Builder;Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    move-result-object v0
    return-object v0
.end method

.method public static putExtrasx(Landroid/content/Intent;Landroid/os/Bundle;)Landroid/content/Intent;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;
    move-result-object v0
    return-object v0
.end method

.method public static putStringx(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public static setClassx(Landroid/content/Intent;Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    move-result-object v0
    return-object v0
.end method

.method public static toStringx(Ljava/lang/Object;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static sendMessagex(Landroid/os/Handler;Landroid/os/Message;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z
    move-result v0
    return v0
.end method

.method public static obtainMessagex(Landroid/os/Handler;IIILjava/lang/Object;)Landroid/os/Message;
    .registers 7
    invoke-virtual/range {p0 .. p4}, Landroid/os/Handler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;
    move-result-object v0
    return-object v0
.end method

.method public static getStringx(Landroid/content/SharedPreferences;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 5
    invoke-interface/range {p0 .. p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static commitx(Landroid/content/SharedPreferences$Editor;)Z
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    move-result v0
    return v0
.end method

.method public static putStringx(Landroid/content/SharedPreferences$Editor;Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    .registers 5
    invoke-interface/range {p0 .. p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    return-object v0
.end method

.method public static editx(Landroid/content/SharedPreferences;)Landroid/content/SharedPreferences$Editor;
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    return-object v0
.end method

.method public static toStringx(Landroid/text/Editable;)Ljava/lang/String;
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/text/Editable;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getTextx(Landroid/widget/EditText;)Landroid/text/Editable;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;
    move-result-object v0
    return-object v0
.end method

.method public static printStackTracex(Ljava/io/IOException;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/IOException;->printStackTrace()V
    return-void
.end method

.method public static closex(Ljava/io/BufferedReader;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/BufferedReader;->close()V
    return-void
.end method

.method public static printStackTracex(Lorg/apache/http/client/ClientProtocolException;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Lorg/apache/http/client/ClientProtocolException;->printStackTrace()V
    return-void
.end method

.method public static readLinex(Ljava/io/BufferedReader;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getContentx(Lorg/apache/http/HttpEntity;)Ljava/io/InputStream;
    .registers 3
    invoke-interface/range {p0 .. p0}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;
    move-result-object v0
    return-object v0
.end method

.method public static getEntityx(Lorg/apache/http/HttpResponse;)Lorg/apache/http/HttpEntity;
    .registers 3
    invoke-interface/range {p0 .. p0}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;
    move-result-object v0
    return-object v0
.end method

.method public static getStatusCodex(Lorg/apache/http/StatusLine;)I
    .registers 3
    invoke-interface/range {p0 .. p0}, Lorg/apache/http/StatusLine;->getStatusCode()I
    move-result v0
    return v0
.end method

.method public static getStatusLinex(Lorg/apache/http/HttpResponse;)Lorg/apache/http/StatusLine;
    .registers 3
    invoke-interface/range {p0 .. p0}, Lorg/apache/http/HttpResponse;->getStatusLine()Lorg/apache/http/StatusLine;
    move-result-object v0
    return-object v0
.end method

.method public static executex(Lorg/apache/http/impl/client/DefaultHttpClient;Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Lorg/apache/http/impl/client/DefaultHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;
    move-result-object v0
    return-object v0
.end method

.method public static addHeaderx(Lorg/apache/http/client/methods/HttpGet;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Lorg/apache/http/client/methods/HttpGet;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public static appendx(Ljava/lang/StringBuilder;Ljava/lang/String;)Ljava/lang/StringBuilder;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    return-object v0
.end method

.method public static setDataAndTypex(Landroid/content/Intent;Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;
    move-result-object v0
    return-object v0
.end method

.method public static parsex(Ljava/lang/String;)Landroid/net/Uri;
    .registers 3
    invoke-static/range {p0 .. p0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v0
    return-object v0
.end method

.method public static valueOfx(Ljava/lang/Object;)Ljava/lang/String;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static setOnClickListenerx(Landroid/widget/Button;Landroid/view/View$OnClickListener;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    return-void
.end method

.method public static setTextx(Landroid/widget/EditText;Ljava/lang/CharSequence;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    return-void
.end method

.method public static putIntx(Landroid/content/SharedPreferences$Editor;Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    .registers 5
    invoke-interface/range {p0 .. p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    return-object v0
.end method

.method public static getIntx(Landroid/content/SharedPreferences;Ljava/lang/String;I)I
    .registers 5
    invoke-interface/range {p0 .. p2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    move-result v0
    return v0
.end method

.method public static addx(Landroid/view/Menu;IIII)Landroid/view/MenuItem;
    .registers 7
    invoke-interface/range {p0 .. p4}, Landroid/view/Menu;->add(IIII)Landroid/view/MenuItem;
    move-result-object v0
    return-object v0
.end method

.method public static ix(Ljava/lang/String;Ljava/lang/String;)I
    .registers 4
    invoke-static/range {p0 .. p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static getItemIdx(Landroid/view/MenuItem;)I
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/view/MenuItem;->getItemId()I
    move-result v0
    return v0
.end method

.method public static loadUrlx(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void
.end method

.method public static setWebViewClientx(Landroid/webkit/WebView;Landroid/webkit/WebViewClient;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    return-void
.end method

.method public static setPluginsEnabledx(Landroid/webkit/WebSettings;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebSettings;->setPluginsEnabled(Z)V
    return-void
.end method

.method public static getSettingsx(Landroid/webkit/WebView;)Landroid/webkit/WebSettings;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v0
    return-object v0
.end method

.method public static setAllowFileAccessx(Landroid/webkit/WebSettings;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    return-void
.end method

.method public static setJavaScriptEnabledx(Landroid/webkit/WebSettings;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    return-void
.end method

.method public static setBuiltInZoomControlsx(Landroid/webkit/WebSettings;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    return-void
.end method

.method public static setSupportZoomx(Landroid/webkit/WebSettings;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    return-void
.end method

.method public static clearFormDatax(Landroid/webkit/WebView;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->clearFormData()V
    return-void
.end method

.method public static clearCachex(Landroid/webkit/WebView;Z)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/webkit/WebView;->clearCache(Z)V
    return-void
.end method

.method public static clearFocusx(Landroid/webkit/WebView;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->clearFocus()V
    return-void
.end method

.method public static clearViewx(Landroid/webkit/WebView;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->clearView()V
    return-void
.end method

.method public static setCookiex(Landroid/webkit/CookieManager;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/webkit/CookieManager;->setCookie(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public static getStringx(Landroid/os/Bundle;Ljava/lang/String;)Ljava/lang/String;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getInstancex()Landroid/webkit/CookieManager;
    .registers 2
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    return-object v0
.end method

.method public static getExtrasx(Landroid/content/Intent;)Landroid/os/Bundle;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;
    move-result-object v0
    return-object v0
.end method

.method public static goBackx(Landroid/webkit/WebView;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->goBack()V
    return-void
.end method

.method public static canGoBackx(Landroid/webkit/WebView;)Z
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/webkit/WebView;->canGoBack()Z
    move-result v0
    return v0
.end method

.method public static writex(Ljava/io/FileOutputStream;[BII)V
    .registers 6
    invoke-virtual/range {p0 .. p3}, Ljava/io/FileOutputStream;->write([BII)V
    return-void
.end method

.method public static shutdownx(Lorg/apache/http/conn/ClientConnectionManager;)V
    .registers 3
    invoke-interface/range {p0 .. p0}, Lorg/apache/http/conn/ClientConnectionManager;->shutdown()V
    return-void
.end method

.method public static getConnectionManagerx(Lorg/apache/http/impl/client/DefaultHttpClient;)Lorg/apache/http/conn/ClientConnectionManager;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getConnectionManager()Lorg/apache/http/conn/ClientConnectionManager;
    move-result-object v0
    return-object v0
.end method

.method public static closex(Ljava/io/FileOutputStream;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/FileOutputStream;->close()V
    return-void
.end method

.method public static closex(Ljava/io/InputStream;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/InputStream;->close()V
    return-void
.end method

.method public static readx(Ljava/io/InputStream;[B)I
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/io/InputStream;->read([B)I
    move-result v0
    return v0
.end method

.method public static addHeaderx(Lorg/apache/http/client/methods/HttpPost;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Lorg/apache/http/client/methods/HttpPost;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public static setParameterx(Lorg/apache/http/params/HttpParams;Ljava/lang/String;Ljava/lang/Object;)Lorg/apache/http/params/HttpParams;
    .registers 5
    invoke-interface/range {p0 .. p2}, Lorg/apache/http/params/HttpParams;->setParameter(Ljava/lang/String;Ljava/lang/Object;)Lorg/apache/http/params/HttpParams;
    move-result-object v0
    return-object v0
.end method

.method public static getParamsx(Lorg/apache/http/impl/client/DefaultHttpClient;)Lorg/apache/http/params/HttpParams;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Lorg/apache/http/impl/client/DefaultHttpClient;->getParams()Lorg/apache/http/params/HttpParams;
    move-result-object v0
    return-object v0
.end method

.method public static printStackTracex(Ljava/lang/Exception;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/Exception;->printStackTrace()V
    return-void
.end method

.method public static mkdirx(Ljava/io/File;)Z
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->mkdir()Z
    move-result v0
    return v0
.end method

.method public static existsx(Ljava/io/File;)Z
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->exists()Z
    move-result v0
    return v0
.end method

.method public static toStringx(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getSharedPreferencesx(Landroid/content/Context;Ljava/lang/String;I)Landroid/content/SharedPreferences;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method public static registerContentObserverx(Landroid/content/ContentResolver;Landroid/net/Uri;ZLandroid/database/ContentObserver;)V
    .registers 6
    invoke-virtual/range {p0 .. p3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V
    return-void
.end method

.method public static setx(Landroid/app/AlarmManager;IJLandroid/app/PendingIntent;)V
    .registers 7
    invoke-virtual/range {p0 .. p4}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V
    return-void
.end method

.method public static getBroadcastx(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    .registers 6
    invoke-static/range {p0 .. p3}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v0
    return-object v0
.end method

.method public static getSubscriberIdx(Landroid/telephony/TelephonyManager;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getDeviceIdx(Landroid/telephony/TelephonyManager;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static elapsedRealtimex()J
    .registers 2
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J
    move-result-wide v0
    return-wide v0
.end method

.method public static contentEqualsx(Ljava/lang/String;Ljava/lang/CharSequence;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z
    move-result v0
    return v0
.end method

.method public static toLowerCasex(Ljava/lang/String;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getTypeNamex(Landroid/net/NetworkInfo;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/net/NetworkInfo;->getTypeName()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static compareToIgnoreCasex(Ljava/lang/String;Ljava/lang/String;)I
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static getExtraInfox(Landroid/net/NetworkInfo;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getActiveNetworkInfox(Landroid/net/ConnectivityManager;)Landroid/net/NetworkInfo;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;
    move-result-object v0
    return-object v0
.end method

.method public static substringx(Ljava/lang/String;II)Ljava/lang/String;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static indexOfx(Ljava/lang/String;Ljava/lang/String;)I
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static replaceAllx(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static startsWithx(Ljava/lang/String;Ljava/lang/String;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    return v0
.end method

.method public static groupx(Ljava/util/regex/Matcher;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static findx(Ljava/util/regex/Matcher;)Z
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/util/regex/Matcher;->find()Z
    move-result v0
    return v0
.end method

.method public static matcherx(Ljava/util/regex/Pattern;Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;
    move-result-object v0
    return-object v0
.end method

.method public static compilex(Ljava/lang/String;)Ljava/util/regex/Pattern;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;
    move-result-object v0
    return-object v0
.end method

.method public static substringx(Ljava/lang/String;I)Ljava/lang/String;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static addx(Ljava/util/List;Ljava/lang/Object;)Z
    .registers 4
    invoke-interface/range {p0 .. p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    move-result v0
    return v0
.end method

.method public static nextIntx(Ljava/util/Random;I)I
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/util/Random;->nextInt(I)I
    move-result v0
    return v0
.end method

.method public static getTimex(Ljava/util/Date;)J
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/util/Date;->getTime()J
    move-result-wide v0
    return-wide v0
.end method

.method public static abortx(Lorg/apache/http/client/methods/HttpGet;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Lorg/apache/http/client/methods/HttpGet;->abort()V
    return-void
.end method

.method public static clearx(Ljava/util/List;)V
    .registers 3
    invoke-interface/range {p0 .. p0}, Ljava/util/List;->clear()V
    return-void
.end method

.method public static getx(Ljava/util/List;I)Ljava/lang/Object;
    .registers 4
    invoke-interface/range {p0 .. p1}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method

.method public static sizex(Ljava/util/List;)I
    .registers 3
    invoke-interface/range {p0 .. p0}, Ljava/util/List;->size()I
    move-result v0
    return v0
.end method

.method public static sleepx(J)V
    .registers 4
    invoke-static/range {p0 .. p1}, Ljava/lang/Thread;->sleep(J)V
    return-void
.end method

.method public static splitx(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static parseIntx(Ljava/lang/String;)I
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static charAtx(Ljava/lang/String;I)C
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->charAt(I)C
    move-result v0
    return v0
.end method

.method public static parseIntx(Ljava/lang/String;I)I
    .registers 4
    invoke-static/range {p0 .. p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I
    move-result v0
    return v0
.end method

.method public static doFinalx(Ljavax/crypto/Cipher;[B)[B
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljavax/crypto/Cipher;->doFinal([B)[B
    move-result-object v0
    return-object v0
.end method

.method public static initx(Ljavax/crypto/Cipher;ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V
    .registers 6
    invoke-virtual/range {p0 .. p3}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V
    return-void
.end method

.method public static getBytesx(Ljava/lang/String;Ljava/lang/String;)[B
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v0
    return-object v0
.end method

.method public static generateSecretx(Ljavax/crypto/SecretKeyFactory;Ljava/security/spec/KeySpec;)Ljavax/crypto/SecretKey;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljavax/crypto/SecretKeyFactory;->generateSecret(Ljava/security/spec/KeySpec;)Ljavax/crypto/SecretKey;
    move-result-object v0
    return-object v0
.end method

.method public static getInstancex(Ljava/lang/String;)Ljavax/crypto/SecretKeyFactory;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljavax/crypto/SecretKeyFactory;->getInstance(Ljava/lang/String;)Ljavax/crypto/SecretKeyFactory;
    move-result-object v0
    return-object v0
.end method

.method public static getInstancex(Ljava/lang/String;)Ljavax/crypto/Cipher;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;
    move-result-object v0
    return-object v0
.end method

.method public static appendx(Ljava/lang/StringBuffer;Ljava/lang/String;)Ljava/lang/StringBuffer;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;
    move-result-object v0
    return-object v0
.end method

.method public static toHexStringx(I)Ljava/lang/String;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static toStringx(Ljava/lang/StringBuffer;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static startServicex(Landroid/content/Context;Landroid/content/Intent;)Landroid/content/ComponentName;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    move-result-object v0
    return-object v0
.end method

.method public static equalsx(Ljava/lang/String;Ljava/lang/Object;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    return v0
.end method

.method public static getActionx(Landroid/content/Intent;)Ljava/lang/String;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static sendTextMessagex(Landroid/telephony/gsm/SmsManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    .registers 8
    invoke-virtual/range {p0 .. p5}, Landroid/telephony/gsm/SmsManager;->sendTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    return-void
.end method

.method public static getDefaultx()Landroid/telephony/gsm/SmsManager;
    .registers 2
    invoke-static {}, Landroid/telephony/gsm/SmsManager;->getDefault()Landroid/telephony/gsm/SmsManager;
    move-result-object v0
    return-object v0
.end method

.method public static deletex(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)I
    .registers 6
    invoke-virtual/range {p0 .. p3}, Landroid/database/sqlite/SQLiteDatabase;->delete(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static valueOfx(I)Ljava/lang/String;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getIntx(Landroid/database/Cursor;I)I
    .registers 4
    invoke-interface/range {p0 .. p1}, Landroid/database/Cursor;->getInt(I)I
    move-result v0
    return v0
.end method

.method public static getStringx(Landroid/database/Cursor;I)Ljava/lang/String;
    .registers 4
    invoke-interface/range {p0 .. p1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static getLongx(Landroid/database/Cursor;I)J
    .registers 4
    invoke-interface/range {p0 .. p1}, Landroid/database/Cursor;->getLong(I)J
    move-result-wide v0
    return-wide v0
.end method

.method public static closex(Landroid/database/sqlite/SQLiteDatabase;)V
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/database/sqlite/SQLiteDatabase;->close()V
    return-void
.end method

.method public static moveToNextx(Landroid/database/Cursor;)Z
    .registers 3
    invoke-interface/range {p0 .. p0}, Landroid/database/Cursor;->moveToNext()Z
    move-result v0
    return v0
.end method

.method public static queryx(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .registers 10
    invoke-virtual/range {p0 .. p7}, Landroid/database/sqlite/SQLiteDatabase;->query(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v0
    return-object v0
.end method

.method public static insertx(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J
    .registers 6
    invoke-virtual/range {p0 .. p3}, Landroid/database/sqlite/SQLiteDatabase;->insert(Ljava/lang/String;Ljava/lang/String;Landroid/content/ContentValues;)J
    move-result-wide v0
    return-wide v0
.end method

.method public static putx(Landroid/content/ContentValues;Ljava/lang/String;Ljava/lang/String;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

.method public static putx(Landroid/content/ContentValues;Ljava/lang/String;Ljava/lang/Integer;)V
    .registers 5
    invoke-virtual/range {p0 .. p2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V
    return-void
.end method

.method public static valueOfx(I)Ljava/lang/Integer;
    .registers 3
    invoke-static/range {p0 .. p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v0
    return-object v0
.end method

.method public static execSQLx(Landroid/database/sqlite/SQLiteDatabase;Ljava/lang/String;)V
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/database/sqlite/SQLiteDatabase;->execSQL(Ljava/lang/String;)V
    return-void
.end method

.method public static getSystemServicex(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;
    .registers 4
    invoke-virtual/range {p0 .. p1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method

.method public static getContentResolverx(Landroid/content/Context;)Landroid/content/ContentResolver;
    .registers 3
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    return-object v0
.end method

.method public static deletex(Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .registers 6
    invoke-virtual/range {p0 .. p3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    move-result v0
    return v0
.end method

.method public static valueOfx(J)Ljava/lang/String;
    .registers 4
    invoke-static/range {p0 .. p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

.method public static appendx(Ljava/lang/StringBuilder;J)Ljava/lang/StringBuilder;
    .registers 5
    invoke-virtual/range {p0 .. p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v0
    return-object v0
.end method

.method public static nextx(Ljava/util/Iterator;)Ljava/lang/Object;
    .registers 3
    invoke-interface/range {p0 .. p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v0
    return-object v0
.end method

.method public static hasNextx(Ljava/util/Iterator;)Z
    .registers 3
    invoke-interface/range {p0 .. p0}, Ljava/util/Iterator;->hasNext()Z
    move-result v0
    return v0
.end method

.method public static iteratorx(Ljava/util/List;)Ljava/util/Iterator;
    .registers 3
    invoke-interface/range {p0 .. p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    return-object v0
.end method

.method public static containsx(Ljava/lang/String;Ljava/lang/CharSequence;)Z
    .registers 4
    invoke-virtual/range {p0 .. p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v0
    return v0
.end method

.method public static queryx(Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .registers 8
    invoke-virtual/range {p0 .. p5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    move-result-object v0
    return-object v0
.end method

