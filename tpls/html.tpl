<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <title>A example</title>
</head>
<body>
    <header> 
        <h1></h1>
        <nav>
            <ul>
                <li>menu1</li>
                <li>menu2</li>
            </ul>
        </nav>
    </header>
    <!-- Note -->
    <article>
        <hgroup>
            <h1>Main title</h1>
            <h2>Title</h2>
        </hgroup>
        <p>Full text</p>
        <section>
            <h1>Form example</h1>
            <datalist id="genderlist">
                <option value="Male"/>
                <option value="Female"/>
                <option value="Unknown"/>
            </datalist>
            <form name=form1>
                <label for=username>Name</label>
                <input name=username id=username type=text required/><br/>
                <label for=usergender>Gender</label>
                <input name=usergender id=usergender type=text list=genderlist required/><br/>
                <label for=userage>Age</label>
                <input name=userage id=userage type=number min=0 max=100 required/><br/>
                <label for=birthday>Birthday</label>
                <input name=birthday id=birthday type=date value=1984-03-29 /><br/>
                <label for=email>Email</label>
                <input name=email id=email type=email required/><br/>
                <label for=webpage>Webpage</label>
                <input name=webpage id=webpage type=url /><br/>
                <label for="memo">Memo</label>
                <textarea name=memo id=memo pattern="[A-Z]{3}" required></textarea><br/>
                <input type=submit value=submit />
            </form>
        </section>
    </article>
    <footer>
        <p align="center">&copy; 2013. All rights reserved.</p>
    </footer>
</body>
