<h2>Register</h2>

@if($errors->any())
    <ul style="color: red">
        @foreach($errors->all() as $error)
            <li>{{ $error }}</li>
        @endforeach
    </ul>
@endif

<form method="POST" action="{{ route('register') }}">
    @csrf
    <div>
        <label for="nama">Name:</label>
        <input type="text" id="nama" name="nama" required>
    </div>
    <div>
        <label for="alamat">Address:</label>
        <input type="text" id="alamat" name="alamat" required>
    </div>
    <div>
        <label for="no_ktp">KTP Number:</label>
        <input type="text" id="no_ktp" name="no_ktp" required>
    </div>
    <div>
        <label for="no_hp">Phone Number:</label>
        <input type="text" id="no_hp" name="no_hp" required>
    </div>
    <div>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div>
        <label for="password_confirmation">Confirm Password:</label>
        <input type="password" id="password_confirmation" name="password_confirmation" required>
    </div>
    <button type="submit">Register</button>

</form>
<p>Already have an account? <a href="{{ route('login') }}">Login here</a></p>