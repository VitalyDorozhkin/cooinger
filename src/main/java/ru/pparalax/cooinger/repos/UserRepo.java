package ru.pparalax.cooinger.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.pparalax.cooinger.domain.User;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
