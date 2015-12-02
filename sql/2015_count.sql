SELECT
  users.nickname,
  count(1) as cnt
FROM incenses
INNER JOIN users ON users.id = incenses.user_id
WHERE
  incenses.created_at
    BETWEEN '2014/12/2' AND '2015/12/3'
GROUP BY
  users.nickname
ORDER BY
  cnt DESC;
